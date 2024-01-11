//
//  ProductService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 25.12.2023.
//

import Foundation
import Alamofire

 
final class ProductService
{
    func productServiceRequest(responseItems:@escaping ([ProductModel])->())
    {
        ServiceManagerGet.sharedService.serviceManagerRequest(url:ConstantVariable.baseUrl + "productGetData.php") {
            (productModelList: [ProductModel]) -> () in
            responseItems(productModelList)
        }
    }
}

