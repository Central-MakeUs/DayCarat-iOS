//
//  UserDTO.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation

struct UserDTO: Decodable {
    let email: String
    let nickname: String
    let profileImage: String
    let jobTitle: String
    let strength: String
    let pushAllow: Bool
}
