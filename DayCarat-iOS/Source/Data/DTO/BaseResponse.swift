//
//  BaseResponse.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

struct BaseResponse<Result: Decodable>: Decodable {
    let statusCode: Int
    let message: String
    let result: Result?
}

struct BaseArrayResponse<Result: Decodable>: Decodable {
    let statusCode: Int
    let message: String
    let result: [Result]?
}
struct Empty: Decodable {}
