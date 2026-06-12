//
//  TaskItem.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

enum TaskPriority: String, Codable, CaseIterable, Identifiable {//classificacao
    case low = "low"
    case medium = "medium"
    case high = "high"
    
    var title: String { //tradutor das classificacoes
        switch self {
        case .low: return "Baixa"
        case .medium: return "Média"
        case .high: return "Alta"
        }
    }
    
    var id: String { self.rawValue }
}


struct TaskItem: Identifiable, Codable { //estrutura dos dados
    var id: UUID = UUID() //gerado automaticamente
    var title: String
    var description: String
    var dueDate: Date
    var priority: TaskPriority
    var isCompleted: Bool
    
    
    enum CodingKeys: String, CodingKey {//lidando com o json
        case title, description, dueDate, priority, isCompleted
    }
    
}
