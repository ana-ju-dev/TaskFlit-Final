//
//  TaskRowView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct TaskRowView: View {
    let task: TaskItem
    var onDeleteAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // 1. O Checkbox (Tocar aqui ou no texto conclui a tarefa)
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundColor(task.isCompleted ? .green : .gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isCompleted, color: .gray)
                    .foregroundColor(task.isCompleted ? .secondary : .primary)
                
                if !task.description.isEmpty {
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                HStack {
                    Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                    Spacer()
                    Text(task.priority.title)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(priorityColor.opacity(0.2))
                        .foregroundColor(priorityColor)
                        .cornerRadius(4)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            // 2. O PULO DO GATO: O Novo Botão de Lixeira Intuitivo
            Button(action: {
                onDeleteAction() // Dispara a ação que vem lá da Home
            }) {
                Image(systemName: "trash")
                    .font(.title3)
                    .foregroundColor(.red.opacity(0.8))
                    .padding(8)
            }
            .buttonStyle(.plain) // 🔥 CRUCIAL: Impede que o clique na lixeira acione a linha inteira!
        }
        .padding(.vertical, 8)
    }
    
    private var priorityColor: Color {
        switch task.priority {
        case .high: return .red
        case .medium: return .orange
        case .low: return .blue
        }
    }
}
