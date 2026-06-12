//
//  AddTaskView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
//semore olhando o que o usuario ta digitando
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .medium
    @State private var showErrorAlert: Bool = false

    var onSave: (TaskItem) -> Void
    
    var body: some View {
        NavigationStack {
            Form { //organizando os campos
                Section(header: Text("Informações Básicas")) {
                    TextField("Título da tarefa", text: $title)//se o usuario nao digitar nada e clicar em salvat, aparece uma borda vermelha
                        .padding(showErrorAlert ? 8 : 0)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: showErrorAlert ? 2 : 0)
                        )
                    TextField("Descrição (Opcional)", text: $description)
                }
 
                Section(header: Text("Prazo e Importância")) {
                    DatePicker(
                        "Data de Vencimento",
                        selection: $dueDate,
                        in: Date.now...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                    .environment(\.locale, Locale(identifier: "pt_BR"))
                    
                    Picker("Prioridade", selection: $priority) {//puxando as prioridades
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
                    Button("Salvar") { //salvando com validacao do campo
                        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                showErrorAlert = true
                            }
                        } else {
                            showErrorAlert = false
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
                    }

                }
            }
        }
    }
}

#Preview {
    AddTaskView(onSave: { _ in })
}
