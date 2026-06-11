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
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack {
                            PhotosPicker(selection: $selectedItem, matching: .images) { //foto de perfil
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
                
                Section(header: Text("Informações Pessoais")) {
                    HStack {
                        Text("Nome") //nome do usuario
                            .frame(width: 60, alignment: .leading)
                        TextField("Digite seu nome", text: $viewModel.name)
                            .disabled(!viewModel.isEditing)
                            .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                            .focused($isInputActive)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("E-mail") //email do usuario
                                .frame(width: 60, alignment: .leading)
                            TextField("Digite seu e-mail", text: $viewModel.email)
                                .focused($isInputActive)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disabled(!viewModel.isEditing)
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
                        Text("Idade") //idade do usuario
                            .frame(width: 60, alignment: .leading)
                        TextField("Sua idade", text: $viewModel.age)
                            .keyboardType(.numberPad)
                            .disabled(!viewModel.isEditing)
                            .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                            .focused($isInputActive)
                    }
                }

                Section(header: Text("Sobre mim")) { //bio do usuario
                    TextEditor(text: $viewModel.bio)
                        .frame(height: 80)
                        .disabled(!viewModel.isEditing)
                        .foregroundColor(viewModel.isEditing ? .primary : .secondary)
                        .focused($isInputActive)
                }
            }
            .navigationTitle("Perfil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.isEditing {
                        Button("Salvar") {
                            isInputActive = false //corrir o bug do teclado
                            viewModel.saveProfile()
                            withAnimation { viewModel.isEditing = false }
                        }
                        .fontWeight(.bold)
                        .disabled(!viewModel.isEmailValid)
                    } else {
                        Button("Editar") {
                            withAnimation { viewModel.isEditing = true }
                        }
                    }
                }

                if viewModel.isEditing {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
                            isInputActive = false //corrir o bug do teclado
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
