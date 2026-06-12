//
//  UserProfile.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import Foundation

struct UserProfile {//escopo dos dados
    var name: String
    var email: String
    var age: String
    var imageData: Data?
}

class UserProfileManager { //lidando com os dados

    private enum Keys {
        static let name = "profile_name"
        static let email = "profile_email"
        static let age = "profile_age"
        static let imageData = "profile_image_data"
    }
    
    static func saveProfile(_ profile: UserProfile) {
        let defaults = UserDefaults.standard
        defaults.set(profile.name, forKey: Keys.name)
        defaults.set(profile.email, forKey: Keys.email)
        defaults.set(profile.age, forKey: Keys.age)
        defaults.set(profile.imageData, forKey: Keys.imageData)
        
        if let data = profile.imageData { //verificando como a imagem ta sendo tratado
                print("DEBUG: Salvando imagem com \(data.count) bytes")
                defaults.set(data, forKey: Keys.imageData)
            } else {
                print("DEBUG: O profile.imageData está NULO (nil)!")
            }
    }
    
    static func getProfile() -> UserProfile {
        let defaults = UserDefaults.standard
        return UserProfile(
            name: defaults.string(forKey: Keys.name) ?? "",
            email: defaults.string(forKey: Keys.email) ?? "",
            age: defaults.string(forKey: Keys.age) ?? "",
            imageData: defaults.data(forKey: Keys.imageData)         )
    }
}
