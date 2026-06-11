//
//  ProfileView.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: Image? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Seção de Foto
                Section {
                    HStack {
                        Spacer()
                        VStack {
                            PhotosPicker(selection: $selectedItem, matching: .images) {
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
                
                // MARK: - Dados Pessoais
                Section(header: Text("Informações Pessoais")) {
                    HStack {
                        Text("Nome")
                            .frame(width: 60, alignment: .leading)
                        TextField("Digite seu nome", text: $viewModel.name)
                            .disabled(!viewModel.isEditing)
                            .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                    }
                    
                    // 1. Mudamos para VStack para o erro ficar EMBAIXO do campo
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("E-mail")
                                .frame(width: 60, alignment: .leading)
                            TextField("Digite seu e-mail", text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disabled(!viewModel.isEditing)
                                .foregroundColor(viewModel.isEmailValid ? (viewModel.isEditing ? .primary : .secondary) : .red)
                                .onChange(of: viewModel.email) { _, _ in
                                    viewModel.validateEmail()
                                }
                        }
                        
                        // 🎯 A EXPLICAÇÃO DO ERRO: Só aparece se o e-mail for inválido E se o usuário estiver editando
                        if !viewModel.isEmailValid && viewModel.isEditing {
                            Text(viewModel.emailErrorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.leading, 64) // Alinha o texto do erro certinho embaixo do TextField
                        }
                    }
                    
                    HStack {
                        Text("Idade")
                            .frame(width: 60, alignment: .leading)
                        TextField("Sua idade", text: $viewModel.age)
                            .keyboardType(.numberPad)
                            .disabled(!viewModel.isEditing)
                            .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                    }
                }
                
                // MARK: - Sobre
                Section(header: Text("Sobre mim")) {
                    TextEditor(text: $viewModel.bio)
                        .frame(height: 80)
                        .disabled(!viewModel.isEditing)
                        .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                }
            }
            .navigationTitle("Perfil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.isEditing {
                        Button("Salvar") {
                            viewModel.saveProfile()
                            withAnimation { viewModel.isEditing = false }
                        }
                        .fontWeight(.bold)
                        .disabled(!viewModel.isEmailValid) // Trava o botão
                    } else {
                        Button("Editar") {
                            withAnimation { viewModel.isEditing = true }
                        }
                    }
                }
                
                if viewModel.isEditing {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
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
                    }
                }
            }
        }
    }
}
