//
//  ProductService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 25.12.2023.
//

import Foundation
import Alamofire

struct datas
{
    let result : [ProductModel]?
}


final class Product
{
    /*func fetchData (onSuccess: @escaping (datas?) -> (), onError: @escaping (AFError) -> ())
    {
        ServiceManager.sharedService.fetchDataRemoteServer(url: "https://dummyjson.com/products") { (response: datas) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
        
    }*/
}


struct ProductService
{
    let prodcutDataHomeView = [
        ProductModel(title: "The Islands!", url: "maxcodes.io/enroll", shortDetail: "shortDetail", longDetail: "longdetail", price: 18.5, image: #imageLiteral(resourceName: "introBg")),
        ProductModel(title: "The Islands!", url: "maxcodes.io/enroll", shortDetail: "shortDetail", longDetail: "longdetail", price: 18.5, image:  #imageLiteral(resourceName: "introBg")),
        ProductModel(title: "The Islands!", url: "maxcodes.io/enroll", shortDetail: "shortDetail", longDetail: "longdetail", price: 18.5, image:  #imageLiteral(resourceName: "introBg")),
        ProductModel(title: "The Islands!", url: "maxcodes.io/enroll", shortDetail: "shortDetail", longDetail: "longdetail", price: 18.5, image:  #imageLiteral(resourceName: "introBg")),
        ProductModel(title: "The Islands!", url: "maxcodes.io/enroll", shortDetail: "shortDetail", longDetail: "longdetail", price: 18.5, image:  #imageLiteral(resourceName: "introBg")),
          ]
}
