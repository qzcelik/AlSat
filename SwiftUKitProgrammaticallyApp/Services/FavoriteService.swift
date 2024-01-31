//
//  FavoriteService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 28.01.2024.
//

import Foundation
import Alamofire

class FavoriteService  : ServiceRequestProtocol
{
    func request(url:String, parameters: [String : Any]?, responseItems: @escaping ([Any]) -> ()) {
        ServiceManager.sharedService.serviceManagerRequest(url:ConstantVariable.baseUrl + url,parameters: parameters) {
            (productModelList: [CheckModel]) -> () in
            responseItems(productModelList)
        }
    }
    
   
}

