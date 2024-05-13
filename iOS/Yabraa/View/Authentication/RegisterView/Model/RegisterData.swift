//
//  RegisterData.swift
//  Yabraa
//
//  Created by Hamada Ragab on 11/09/2023.
//

import Foundation
class RegisterData {
    static let shared = RegisterData()
    var registerData: [String: Any]?
    var verificationCode: String?
}
