//
//  EditTaskView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title: String
    @State private var description: String
    @State private var dueDate: Date
    @State private var priority: TaskPriority

    let originalTask: TaskItem
    var onSave: (TaskItem) -> Void

    init(task: TaskItem, onSave: @escaping (TaskItem) -> Void) {//carregando os dados do formulário de tarefas
        self.originalTask = task
        self.onSave = onSave

        _title = State(initialValue: task.title)
        _description = State(initialValue: task.description)
        _dueDate = State(initialValue: task.dueDate)
        _priority = State(initialValue: task.priority)
    }
    
    var body: some View {
        NavigationStack {
            Form { //deixando o usuario editar os dados
                Section(header: Text("Editar Informações")) {
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
            .navigationTitle("Editar Tarefa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        let updatedTask = TaskItem(
                            id: originalTask.id,
                            title: title,
                            description: description,
                            dueDate: dueDate,
                            priority: priority,
                            isCompleted: originalTask.isCompleted
                        )
                        onSave(updatedTask)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
