//
//   TaskListView.swift
//   TaskFlit
//
//   Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct TaskListView: View {
    
    @State private var viewModel = TaskViewModel()
    @State private var isShowingAddTaskSheet = false
    @State private var taskToEdit: TaskItem? = nil
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                VStack(spacing: 0) {
                    Picker("Filtro", selection: $viewModel.selectedFilter) {
                        ForEach(TaskViewModel.AppFilter.allCases) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(Color(.systemBackground))

                    List {
                        if viewModel.filteredTasks.isEmpty {
                            EmptyStateView(currentFilter: viewModel.selectedFilter)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        } else {
                            
                            ForEach(viewModel.filteredTasks) { task in
                                TaskRowView(task: task) {
                                    if let index = viewModel.allTasks.firstIndex(where: { $0.id == task.id }) {
                                        withAnimation(.easeInOut) {
                                            viewModel.allTasks.remove(at: index)
                                            StorageService.saveTasks(viewModel.allTasks)
                                        }
                                    }
                                } onCheckToggle: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        viewModel.toggleTaskCompletion(task: task)
                                    }
                                }
                                .listRowSeparator(.visible)
                                .listRowBackground(Color(.secondarySystemBackground).opacity(0.4))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    taskToEdit = task
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                
                // 🛠️ NOVO: Botão Flutuante Expandido (Mais acessível para os pais!)
                Button(action: {
                    isShowingAddTaskSheet = true
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                        Text("Nova Tarefa")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(width: 130, height: 48) // 🔥 Largura e altura fixas para não empurrar nada!
                    .background(Color.accentColor)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
                .padding(.trailing, 16)
                .padding(.bottom, 16)
            }
            .navigationTitle("TaskFlit")
            .searchable(text: $viewModel.searchText, prompt: "Buscar tarefa...")
            .sheet(isPresented: $isShowingAddTaskSheet) {
                AddTaskView { newTask in
                    withAnimation(.spring()) {
                        viewModel.addTask(newTask)
                    }
                }
            }
            .sheet(item: $taskToEdit) { task in
                EditTaskView(task: task) { updatedTask in
                    withAnimation {
                        viewModel.updateTask(updatedTask)
                    }
                }
            }
        }
    }
}

#Preview {
    TaskListView()
}
