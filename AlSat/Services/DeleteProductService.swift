//
//  DeleteProductService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 12.02.2024.
//

import Foundation
import Alamofire

final class DeleteProductService : ServiceRequestProtocol
{
    func request(url: String, parameters: [String : Any]?, method: HTTPMethod,responseItems: @escaping ([Any]) -> ()) {
 
        ServiceManager.sharedService.serviceManagerRequest(url:ConstantVariable.baseUrl + url,parameters: parameters,method:method) {
            (productModelList: [CheckModel]) -> () in
            responseItems(productModelList)
        }
    }
    
}
