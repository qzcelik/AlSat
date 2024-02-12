//
//  DeleteProductService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 12.02.2024.
//

import Foundation

final class DeleteProductService : ServiceRequestProtocol
{
    func request(url: String, parameters: [String : Any]?, responseItems: @escaping ([Any]) -> ()) {
 
        ServiceManager.sharedService.serviceManagerRequest(url:ConstantVariable.baseUrl + url,parameters: parameters) {
            (productModelList: [CheckModel]) -> () in
            responseItems(productModelList)
        }
    }
    
}
