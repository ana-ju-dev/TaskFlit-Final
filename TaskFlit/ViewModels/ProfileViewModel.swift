//
//  ProfileViewModel.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

@Observable
class ProfileViewModel {
    // Caixinhas de texto que a View vai ler e escrever
    var name: String = ""
    var email: String = ""
    var age: String = ""
    var bio: String = ""
    var isEditing: Bool = false
    var isEmailValid: Bool = true
    var emailErrorMessage: String = ""
    
    init() {
        loadProfile()
    }
    
    func loadProfile() {
        let profile = UserProfileManager.getProfile()
        self.name = profile.name
        self.email = profile.email
        self.age = profile.age
        self.bio = profile.bio
        
        // Sempre que carrega, roda a checagem inicial
        validateEmail()
    }
    
    func validateEmail() {
            // Se estiver vazio, não mostra erro nenhum
            if email.isEmpty {
                isEmailValid = true
                emailErrorMessage = ""
                return
            }
            
            // Validação tradicional passo a passo
            if !email.contains("@") {
                isEmailValid = false
                emailErrorMessage = "O e-mail precisa conter o símbolo '@'."
            } else if !email.contains(".") {
                isEmailValid = false
                emailErrorMessage = "O e-mail precisa conter um ponto (ex: .com)."
            } else {
                isEmailValid = true
                emailErrorMessage = "" // E-mail aprovado, limpa o erro!
            }
        }
    
    func saveProfile() {
            let newProfile = UserProfile(name: name, email: email, age: age, bio: bio)
            UserProfileManager.saveProfile(newProfile)
        }
    }
