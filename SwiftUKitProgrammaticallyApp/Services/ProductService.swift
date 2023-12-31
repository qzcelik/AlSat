//
//  ProductService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 25.12.2023.
//

import Foundation
import Alamofire

 
final class proTest
{
    
    func pro(responseItems:@escaping ([ProductModel])->())
    {
        ServiceManager.sharedService.pro(url: "https://ibrahimozcelik.net/iosapp/productGetData.php") {
            (_test: [ProductModel]) -> () in
            responseItems(_test)
        }
    }
}

