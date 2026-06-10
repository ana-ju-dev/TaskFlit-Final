//
//  TaskViewModel.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

@Observable
class TaskViewModel {
    var allTasks: [TaskItem] = []
    
    var selectedFilter: AppFilter = .all
    
    enum AppFilter: String, CaseIterable, Identifiable {
        case all = "Todas"
        case pending = "Pendentes"
        case completed = "Concluídas"
        
        var id: String { self.rawValue }
    }

    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        self.allTasks = StorageService.loadMockTasks()
    }
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
    
    func toggleTaskCompletion(task: TaskItem) {
        if let index = allTasks.firstIndex(where: { $0.id == task.id }) {
            allTasks[index].isCompleted.toggle()
        }
    }

    func addTask(_ task: TaskItem) {
        allTasks.insert(task, at: 0)
    }
    
    func deleteTask(at offsets: IndexSet) {
        // 1. Descobre qual item foi arrastado usando o índice do filtro atual
        for index in offsets {
            let taskToDelete = filteredTasks[index]
            
            // 2. Remove o item correspondente da nossa lista principal (allTasks)
            if let mainIndex = allTasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                allTasks.remove(at: mainIndex)
            }
        }
    }
}
