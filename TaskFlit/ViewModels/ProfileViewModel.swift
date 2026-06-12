//
//  ProfileViewModel.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import Foundation

@Observable //observando os estados
class ProfileViewModel {
    var name: String = ""
    var email: String = ""
    var age: String = ""
    var profileImageData: Data?
    var isEditing: Bool = false
    var isEmailValid: Bool = true
    var emailErrorMessage: String = ""
    var completedTasksCount: Int = 0
    var pendingTasksCount: Int = 0
    
    init() { //procurando as informacoes salvas
        loadProfile()
        loadTaskStats()
    }
    
    func loadProfile() { //ponte pra atualizar o que ta salvo na memoria
            let profile = UserProfileManager.getProfile()
            self.name = profile.name
            self.email = profile.email
            self.age = profile.age
            self.profileImageData = profile.imageData 
            validateEmail()
        }
    
    func saveProfile() {
            //ponte pra atualizar o que ta salvo na memoria tambem
            let newProfile = UserProfile(name: name, email: email, age: age, imageData: profileImageData)
            UserProfileManager.saveProfile(newProfile)
        }
    
    func loadTaskStats() { //carrega as tarefas filtradas
        let allTasks = StorageService.loadTasks()
        self.completedTasksCount = allTasks.filter { $0.isCompleted }.count
        self.pendingTasksCount = allTasks.filter { !$0.isCompleted }.count
    }
    
    func validateEmail() { //validando o email
        if email.isEmpty {
            isEmailValid = true
            emailErrorMessage = ""
            return
        }
        
        if !email.contains("@") {
            isEmailValid = false
            emailErrorMessage = "O e-mail precisa conter o símbolo '@'."
        } else if !email.contains(".") {
            isEmailValid = false
            emailErrorMessage = "O e-mail precisa conter um ponto (ex: .com)."
        } else {
            isEmailValid = true
            emailErrorMessage = ""
        }
    }
}
