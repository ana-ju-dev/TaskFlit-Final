//
//  TaskListView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct TaskListView: View {
    @State private var viewModel = TaskViewModel()
    @State private var isShowingAddTaskSheet = false
    
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
                                        .listRowBackground(Color.clear) // Mantém o fundo transparente
                                        .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        } else {
                            ForEach(viewModel.filteredTasks) { task in
                                // Passamos a tarefa e criamos a ação de deletar direto no botão dela
                                TaskRowView(task: task) {
                                    // Encontra o índice dessa tarefa específica para apagar
                                    if let index = viewModel.allTasks.firstIndex(where: { $0.id == task.id }) {
                                        withAnimation(.easeInOut) {
                                            viewModel.allTasks.remove(at: index)
                                            StorageService.saveTasks(viewModel.allTasks)
                                        }
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        viewModel.toggleTaskCompletion(task: task)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                
                Button(action: {
                    isShowingAddTaskSheet = true
                })
                {
                    Image(systemName: "plus")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
            .sheet(isPresented: $isShowingAddTaskSheet) {
                AddTaskView { newTask in
                  
                    withAnimation(.spring()) {
                        viewModel.addTask(newTask)
                    }
                }
            }
            .navigationTitle("TaskFlit")
        }
    }
}

#Preview {
    TaskListView()
}
