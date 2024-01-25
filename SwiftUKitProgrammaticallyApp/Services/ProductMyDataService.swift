//
//  ProductMyDataService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 25.01.2024.
//
 
import Foundation
import Alamofire

 
final class ProductMyDataService
{
    func productServiceRequest(responseItems:@escaping ([ProductModel])->())
    {
        
        let parameters: [String: Any] = [
            "userId" : LoginViewController.user.id! as Any
        ]
        
        ServiceManagerGet.sharedService.serviceManagerRequest(url:ConstantVariable.baseUrl + "productGetMyData.php", parameters: parameters) {
            (productModelList: [ProductModel]) -> () in
            responseItems(productModelList)
        }
    }
}

