//
//  MessageListService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 9.04.2024.
//


import Foundation
import Alamofire

class MessageListService : ServiceRequestProtocol
{
    func request(url: String, parameters: [String : Any]?, method: Alamofire.HTTPMethod, responseItems: @escaping ([Any]) -> ()) {
        ServiceManager.sharedService.serviceManagerRequest(url:ConstantVariable.baseUrl + url,parameters: parameters,method:method) {
            (messageModelList: [MessageModel]) -> () in
            responseItems(messageModelList)
        }
    }
}
