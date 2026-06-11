//
//  UserProfile.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import Foundation

struct UserProfile {
    var name: String
    var email: String
    var age: String
    var bio: String
}

class UserProfileManager {

    private enum Keys {
        static let name = "profile_name"
        static let email = "profile_email"
        static let age = "profile_age"
        static let bio = "profile_bio"
    }
    
    static func saveProfile(_ profile: UserProfile) {
        let defaults = UserDefaults.standard
        defaults.set(profile.name, forKey: Keys.name)
        defaults.set(profile.email, forKey: Keys.email)
        defaults.set(profile.age, forKey: Keys.age)
        defaults.set(profile.bio, forKey: Keys.bio)
    }
    
    static func getProfile() -> UserProfile {
        let defaults = UserDefaults.standard
        return UserProfile(
            name: defaults.string(forKey: Keys.name) ?? "",
            email: defaults.string(forKey: Keys.email) ?? "",
            age: defaults.string(forKey: Keys.age) ?? "",
            bio: defaults.string(forKey: Keys.bio) ?? ""
        )
    }
}
