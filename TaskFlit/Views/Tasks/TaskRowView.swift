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
    var onCheckToggle: () -> Void
    
    private var priorityColor: Color {
        switch task.priority {
        case .high: return .red
        case .medium: return .orange
        case .low: return .blue
        }
    }
    
    var body: some View {
        HStack(spacing: 14) {
  
            Button(action: {
                onCheckToggle()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                // Título
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

                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                        Text(task.dueDate.formatted(date: .abbreviated, time: .shortened))
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)

                    Text(task.priority.title)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(priorityColor.opacity(0.15))
                        .foregroundColor(priorityColor)
                        .cornerRadius(4)
                }
            }
            
            Spacer()

            Button(action: {
                onDeleteAction()
            }) {
                Image(systemName: "trash")
                    .font(.title3)
                    .foregroundColor(.red.opacity(0.8))
                    .padding(8)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}
