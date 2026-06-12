//
//  TaskRowView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct TaskRowView: View {

    //as variaveis recebem os dados e manda pra viewmodel
    let task: TaskItem
    var onDeleteAction: () -> Void
    var onCheckToggle: () -> Void
    
    private var priorityColor: Color { //estilizando as cores das prioridades
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
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle") //marcando a bolinha quando o usuario aperta para conluir a tarefa
                    .font(.title2)
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isCompleted, color: .gray) //deixando o texto riscado quando concluido
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
                onDeleteAction() //botao de deletar
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
