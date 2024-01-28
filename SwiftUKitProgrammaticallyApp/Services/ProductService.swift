//
//  ProductService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 25.12.2023.
//

import Foundation
import Alamofire

 
final class ProductService : ServiceRequestProtocol
{
    func request(url: String, parameters: [String : Any]?, responseItems: @escaping ([Any]) -> ()) {
       
        ServiceManager.sharedService.serviceManagerRequest(url:ConstantVariable.baseUrl + url,parameters: parameters) {
            (productModelList: [ProductModel]) -> () in
            responseItems(productModelList)
        }
    }
    
    
}

