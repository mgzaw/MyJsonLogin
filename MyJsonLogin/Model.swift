//
//  Info.swift
//  MyJsonLogin
//
//  Created by U Moe Nyo Gyi on 2021/08/01.
//

import Foundation

struct UserInfo: Decodable {
    let Clientcode: String
    let Clientname: String
    let Usercode: String
    let Username: String
    let Token: String
}

struct LoginInfo: Encodable {
    let Usercode: String
    let Password: String
}

struct ErrorResponse: Decodable, LocalizedError {
    let reason: String
    
    var errorDescription: String? { return reason }
}

