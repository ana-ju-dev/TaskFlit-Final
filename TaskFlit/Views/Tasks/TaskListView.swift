//
//  TaskListView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct TaskListView: View {
    @State private var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationStack {
            // Usamos o ZStack para conseguir flutuar o botão por cima da lista!
            ZStack(alignment: .bottomTrailing) {
                
                VStack(spacing: 0) {
                    // Seletor de Filtros com um espaçamento elegante
                    Picker("Filtro", selection: $viewModel.selectedFilter) {
                        ForEach(TaskViewModel.AppFilter.allCases) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(Color(.systemBackground)) // Garante fundo sólido no topo
                    
                    // A Lista de Tarefas
                    List {
                        if viewModel.filteredTasks.isEmpty {
                            ContentUnavailableView(
                                "Nenhuma Tarefa",
                                systemImage: "doc.text.magnifyingglass",
                                description: Text("Você não tem tarefas neste filtro.")
                            )
                            .listRowBackground(Color.clear) // Remove o fundo da célula de aviso
                        } else {
                            ForEach(viewModel.filteredTasks) { task in
                                TaskRowView(task: task)
                                    .listRowSeparator(.visible) // Mantém uma linha sutil divisória
                                    .listRowBackground(Color(.secondarySystemBackground).opacity(0.4)) // Células levemente destacadas
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                            viewModel.toggleTaskCompletion(task: task)
                                        }
                                    }
                            }
                        }
                    }
                    .listStyle(.insetGrouped) // Muda para o estilo agrupado moderno (com bordas arredondadas nas laterais)
                }
                
                Button(action: {
                    print("Botão de adicionar clicado!")
                    // Próximo passo: abrir a tela de cadastro aqui
                }) {
                    Image(systemName: "plus")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.accentColor) // Usa a cor principal do seu app
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
                .padding(.trailing, 24) // Afasta o botão da borda direita
                .padding(.bottom, 24)   // Afasta o botão do fundo da tela
            }
            .navigationTitle("TaskFlit")
        }
    }
}

#Preview {
    TaskListView()
}
