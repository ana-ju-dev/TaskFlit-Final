//
//  TaskItem.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

enum TaskPriority: String, Codable, CaseIterable, Identifiable {
    case low = "low"
    case medium = "medium"
    case high = "high"
    
    var title: String {
        switch self {
        case .low: return "Baixa"
        case .medium: return "Média"
        case .high: return "Alta"
        }
    }
    
    var id: String { self.rawValue }
}


struct TaskItem: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var priority: TaskPriority
    var isCompleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case title, description, dueDate, priority, isCompleted
    }
}
