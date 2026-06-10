//
//  AddTaskView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .medium

    var onSave: (TaskItem) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Informações Básicas")) {
                    TextField("Título da tarefa", text: $title)
                    TextField("Descrição (Opcional)", text: $description)
                }

                Section(header: Text("Prazo e Importância")) {
                    DatePicker("Data de Entrega", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                        .environment(\.locale, Locale(identifier: "pt_BR"))
                    
                    Picker("Prioridade", selection: $priority) {
                        ForEach(TaskPriority.allCases) { priorityCase in
                            Text(priorityCase.title).tag(priorityCase)
                        }
                    }
                }
            }
            .navigationTitle("Nova Tarefa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        let newTask = TaskItem(
                            title: title,
                            description: description,
                            dueDate: dueDate,
                            priority: priority,
                            isCompleted: false
                        )
                        onSave(newTask)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(onSave: { _ in })
}
