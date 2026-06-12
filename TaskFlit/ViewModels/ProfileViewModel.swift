//
//  ProfileViewModel.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import Foundation

@Observable
class ProfileViewModel {

    var name: String = ""
    var email: String = ""
    var age: String = ""
    var isEditing: Bool = false
    var isEmailValid: Bool = true
    var emailErrorMessage: String = ""
    
    var completedTasksCount: Int = 0
    var pendingTasksCount: Int = 0
    
    init() {
        loadProfile()
        loadTaskStats()
    }
    
    func loadProfile() {
        let profile = UserProfileManager.getProfile()
        self.name = profile.name
        self.email = profile.email
        self.age = profile.age

        validateEmail()
    }
    
    func saveProfile() {
        let newProfile = UserProfile(name: name, email: email, age: age)
        UserProfileManager.saveProfile(newProfile)
    }
    
    func loadTaskStats() {
        let allTasks = StorageService.loadTasks()
        self.completedTasksCount = allTasks.filter { $0.isCompleted }.count
        self.pendingTasksCount = allTasks.filter { !$0.isCompleted }.count
    }
    
    func validateEmail() {
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
