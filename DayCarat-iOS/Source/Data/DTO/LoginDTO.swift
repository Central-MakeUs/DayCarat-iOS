//
//  LoginDTO.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

struct LoginRequest: Decodable {
    let token: String
}

struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
