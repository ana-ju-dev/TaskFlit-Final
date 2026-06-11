//
//  MainTabView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {

            TaskListView()
                .tabItem {
                    Label("Tarefas", systemImage: "checklist")
                }
            
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
