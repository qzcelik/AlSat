//
//  UserService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 28.01.2024.
//

import Foundation

class UserService : ServiceRequestProtocol
{
    func request(url: String, parameters: [String: Any]? ,  responseItems: @escaping ([Any]) -> ()) {
        ServiceManager.sharedService.serviceManagerRequest(url: ConstantVariable.baseUrl + url, parameters: parameters) { (users : [UserModel]) -> ()  in
            responseItems(users)
        }
    }
}
