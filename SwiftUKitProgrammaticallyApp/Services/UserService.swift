//
//  UserService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 28.01.2024.
//

import Foundation
import Alamofire

class UserService : ServiceRequestProtocol
{
    func request(url: String, parameters: [String: Any]? , method:HTTPMethod, responseItems: @escaping ([Any]) -> ()) {
        ServiceManager.sharedService.serviceManagerRequest(url: ConstantVariable.baseUrl + url, parameters: parameters,method: method) { (users : [UserModel]) -> ()  in
            responseItems(users)
        }
    }
}
