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
