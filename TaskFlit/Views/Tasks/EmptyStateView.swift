//
//  EmptyStateView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import SwiftUI

struct EmptyStateView: View {
    // Recebemos o filtro atual para mudar o texto dinamicamente!
    let currentFilter: TaskViewModel.AppFilter
    
    // Variáveis computadas para entregar o ícone e o texto certos
    private var iconName: String {
        switch currentFilter {
        case .all: return "clipboard"
        case .pending: return "sparkles"
        case .completed: return "checkmark.seal"
        }
    }
    
    private var title: String {
        switch currentFilter {
        case .all: return "Tudo limpo por aqui!"
        case .pending: return "Nenhuma pendência!"
        case .completed: return "Ainda nada feito."
        }
    }
    
    private var subtitle: String {
        switch currentFilter {
        case .all: return "Que tal usar o botão de '+' abaixo para começar a organizar o seu dia?"
        case .pending: return "Você está com a sua lista em dia. Aproveite para descansar ou criar novos focos!"
        case .completed: return "As tarefas que você concluir vão aparecer com destaque nesta aba."
        }
    }
    
    private var iconColor: Color {
        switch currentFilter {
        case .all: return .accentColor
        case .pending: return .orange
        case .completed: return .green
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            // 1. O Ícone central estilizado com um fundo suave
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: iconName)
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            .padding(.top, 40)
            
            // 2. Os Textos explicativos
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
        }
        .padding()
    }
}
