//
//   TaskListView.swift
//   TaskFlit
//
//   Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct TaskListView: View {
    //os dados vem da viewmodel
    @State private var viewModel = TaskViewModel()
    @State private var isShowingAddTaskSheet = false
    @State private var taskToEdit: TaskItem? = nil
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                VStack(spacing: 0) {
                    Picker("Filtro", selection: $viewModel.selectedFilter) { //criando botoes pra navegar entre os filtros de tarefas
                        ForEach(TaskViewModel.AppFilter.allCases) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(Color(.systemBackground))

                    List {
                        if viewModel.filteredTasks.isEmpty { //exibindo as tarefas ou os filtros de vazios
                            if !viewModel.searchText.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray.opacity(0.7))
                                        .padding(.top, 40)
                                    
                                    Text("Nenhum resultado encontrado")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    
                                    Text("Não encontramos tarefas correspondentes a \"\(viewModel.searchText)\".")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 24)
                                }
                                .frame(maxWidth: .infinity)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            } else {
                                EmptyStateView(currentFilter: viewModel.selectedFilter)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
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
                
                Button(action: { //botao intuitivo de criar nova tarefa
                    isShowingAddTaskSheet = true
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                        Text("Nova Tarefa")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(width: 130, height: 48)
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
