//
//  TaskViewModel.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

// @Observable é o recurso moderno do iOS 17+ para monitorar mudanças de estado
@Observable
class TaskViewModel {
    // 1. A fonte da verdade: nossa lista de tarefas na memória
    var allTasks: [TaskItem] = []
    
    // 2. Filtro selecionado atualmente (Todas, Pendentes, Concluídas)
    var selectedFilter: AppFilter = .all
    
    enum AppFilter: String, CaseIterable, Identifiable {
        case all = "Todas"
        case pending = "Pendentes"
        case completed = "Concluídas"
        
        var id: String { self.rawValue }
    }
    
    // 3. Inicializador: Carrega os dados assim que a ViewModel nasce
    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        // Busca as tarefas que decodificamos do JSON no StorageService
        self.allTasks = StorageService.loadMockTasks()
    }
    
    // 4. Variável Computada Inteligente: Entrega a lista já filtrada para a View
    var filteredTasks: [TaskItem] {
        switch selectedFilter {
        case .all:
            return allTasks
        case .pending:
            return allTasks.filter { !$0.isCompleted }
        case .completed:
            return allTasks.filter { $0.isCompleted }
        }
    }
    
    // 5. Função para alternar o status da tarefa
    func toggleTaskCompletion(task: TaskItem) {
        if let index = allTasks.firstIndex(where: { $0.id == task.id }) {
            allTasks[index].isCompleted.toggle()
        }
    }
}
