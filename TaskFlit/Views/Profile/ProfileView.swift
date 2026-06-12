//
//  ProfileView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel() //comunicando com a viewmodel
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    @FocusState private var isInputActive: Bool //verificando se o usuario tocou nos campos para ativar a edicao
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack {
                            PhotosPicker(selection: $selectedItem, matching: .images) { //vendo se tem imagem de perfil ou nao - componentes nativos
                                if let profileImage {
                                    profileImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: 100))
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .disabled(!viewModel.isEditing)
                            
                            if viewModel.isEditing {
                                Text("Alterar Foto")
                                    .font(.caption)
                                    .foregroundColor(.accentColor)
                            }
                        }
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Informações Pessoais")) { //formularios do perfil
                    HStack {
                        Text("Nome")
                            .frame(width: 60, alignment: .leading)
                        TextField("Digite seu nome", text: $viewModel.name)
                            .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                            .focused($isInputActive)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("E-mail")
                                .frame(width: 60, alignment: .leading)
                            TextField("Digite seu e-mail", text: $viewModel.email)
                                .focused($isInputActive)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .foregroundColor(viewModel.isEmailValid ? (viewModel.isEditing ? .primary : .secondary) : .red)
                                .onChange(of: viewModel.email) { _, _ in
                                    viewModel.validateEmail()
                                }
                        }
                    
                        if !viewModel.isEmailValid && viewModel.isEditing {
                            Text(viewModel.emailErrorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.leading, 64)
                        }
                    }
                    
                    HStack {
                        Text("Idade")
                            .frame(width: 60, alignment: .leading)
                        TextField("Sua idade", text: $viewModel.age)
                            .keyboardType(.numberPad)
                            .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                            .focused($isInputActive)
                    }
                }
  
                Section(header: Text("Minha Produtividade")) { //exibindo no perfil a quantidade de tarefas concluidas e pendentes
                    HStack(spacing: 0) {
                        VStack(spacing: 6) {
                            HStack(spacing: 6) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Concluídas")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Text("\(viewModel.completedTasksCount)")
                                .font(.title.bold())
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                            .frame(height: 40)
                        
                        VStack(spacing: 6) {
                            HStack(spacing: 6) {
                                Image(systemName: "clock.fill")
                                    .foregroundColor(.orange)
                                Text("Pendentes")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Text("\(viewModel.pendingTasksCount)")
                                .font(.title.bold())
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Perfil")
            .onAppear {
                viewModel.loadTaskStats()
                viewModel.loadProfile()
                
                //convertendo os dados carregados pelo ViewModel em uma imagem exibivel
                if let data = viewModel.profileImageData, let uiImage = UIImage(data: data) {
                    profileImage = Image(uiImage: uiImage)
                }
            }
            .onChange(of: isInputActive) { _, newValue in
                if newValue == true {
                    withAnimation(.easeInOut) {
                        viewModel.isEditing = true
                    }
                }
            }
            .toolbar { //so deixa os botoes de salvar e cancelar aparecendo se tiver no modo de edicao
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.isEditing {
                        Button("Salvar") {
                            isInputActive = false
                            viewModel.saveProfile()
                            withAnimation { viewModel.isEditing = false }
                        }
                        .fontWeight(.bold)
                        .disabled(!viewModel.isEmailValid)
                    }
                }

                if viewModel.isEditing {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
                            isInputActive = false
                            viewModel.loadProfile()
                            withAnimation { viewModel.isEditing = false }
                        }
                    }
                }
            }

            .onChange(of: selectedItem) { _, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {

                        profileImage = Image(uiImage: uiImage)

                        viewModel.profileImageData = data
                    }
                }
            }
            }
        }
    }


#Preview {
    ProfileView()
}
