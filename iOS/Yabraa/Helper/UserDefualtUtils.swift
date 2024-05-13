//
//  UserDefualtUtils.swift
//  Yabraa
//
//  Created by Hamada Ragab on 27/02/2023.
//

import Foundation
public class UserDefualtUtils {
    static private let isOnbordingViewed = "isOnbordingViewed"
    static private let currentLanguage = "currentLanguage"
    static private let userToken = "token"
    static private let userName = "userName"
    static private let firstName = "firstName"
    static private let lastName = "lastName"
    static private let firebaseToken = "firebaseToken"
    static private let isAuthenticated = "isAuthenticated"
    static private let phoneNumber = "phoneNumber"
    static private let userDefualt = UserDefaults.standard
    static private let encoder = JSONEncoder()

    static func setIsOnbordingViewed(isViewed: Bool) {
        userDefualt.setValue(isViewed, forKey: isOnbordingViewed)
    }
    static func getIsOnbordingViewed() -> Bool {
       return userDefualt.bool(forKey: isOnbordingViewed)
    }
    static func setCurrentLang(lang: String) {
        userDefualt.setValue(lang, forKey: currentLanguage)
    }
    static func getCurrentLanguage() -> String {
        return userDefualt.string(forKey: currentLanguage) ?? "ar"
    }
    static func setToken(token: String) {
        userDefualt.setValue(token, forKey: userToken)
    }
    static func getToken() -> String? {
        return userDefualt.string(forKey: userToken)
    }
    static func setIsAuthenticated(authenticated: Bool) {
        userDefualt.setValue(authenticated, forKey: isAuthenticated)
    }
    static func getIsAuthenticated() -> Bool {
        return userDefualt.bool(forKey: isAuthenticated) 
    }
    static func setPhoneNumber(phone: String) {
        userDefualt.setValue(phone, forKey: phoneNumber)
    }
    static func getPhoneNumber() -> String {
        return userDefualt.string(forKey: phoneNumber) ?? ""
    }
    static func setName(name: String) {
        userDefualt.setValue(name, forKey: userName)
    }
    static func getUserName() -> String {
        return userDefualt.string(forKey: userName) ?? ""
    }
    static func setFirstName(name: String) {
        userDefualt.setValue(name, forKey: firstName)
    }
    static func getFirstName() -> String {
        return userDefualt.string(forKey: firstName) ?? ""
    }
    static func setLastName(name: String) {
        userDefualt.setValue(name, forKey: lastName)
    }
    static func getLastName() -> String {
        return userDefualt.string(forKey: lastName) ?? ""
    }
    static func setFirebaseToken(token: String) {
        userDefualt.setValue(token, forKey: firebaseToken)
    }
    static func getFirebaseToken() -> String {
        return userDefualt.string(forKey: firebaseToken) ?? ""
    }
    static func logout() {
        userDefualt.removeObject(forKey: firstName)
        userDefualt.removeObject(forKey: userToken)
        userDefualt.removeObject(forKey: isAuthenticated)
        userDefualt.removeObject(forKey: userName)
        userDefualt.removeObject(forKey: phoneNumber)
        
    }
    static func isArabic() -> Bool {
        return LocalizationManager.shared.getLanguage() == .Arabic
    }
}

