//
//  TokenManger.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/16/24.
//

import Foundation

class TokenManager {
    private let userDefaults = UserDefaults.standard
    private let tokenKey = "accessToken"
    private let FCMToken = "FCMToken"
    
    func saveFcmToken(_ token: String) {
        userDefaults.set(token, forKey: FCMToken)
    }

    func getFcmToken() -> String? {
        return userDefaults.string(forKey: FCMToken)
    }

    func clearFcmToken() {
        userDefaults.removeObject(forKey: FCMToken)
    }
    
    func saveToken(_ token: String) {
        userDefaults.set(token, forKey: tokenKey)
    }

    func getToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }

    func clearToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
}
