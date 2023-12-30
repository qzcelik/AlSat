//
//  ProductService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 25.12.2023.
//

import Foundation
import Alamofire

struct datas : Codable
{
    let result : [ProductModel]?
}


/*final class ProductService
{
    func fetchData (onSuccess: @escaping (datas?) -> (), onError: @escaping (AFError) -> ())
    {
        ServiceManager.sharedService.fetchDataRemoteServer(url: "https://ibrahimozcelik.net/iosapp/productGetData.php") { (response: datas) in
            onSuccess(response)
            debugPrint(response)
        } onError: { error in
            onError(error)
        }
        
    }
    
    
}
 */

final class proTest
{

    var items : [ProductModel] = []
    
    func pro(responseItems:@escaping ([ProductModel])->())
    {
        let decoder : JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        AF.request("https://ibrahimozcelik.net/iosapp/productGetData.php").validate(statusCode: 200..<300).responseString(completionHandler: {str in
                print("str", str)
        }).responseDecodable(of: [ProductModel].self,decoder: decoder){
            response in
            switch response.result{
            case .success(let items):
                self.items = items
                responseItems(self.items)
            case.failure(let error):
                print("items error",error)
            }
        }
    }
}


/*struct ProductService
{
   let prodcutDataHomeView = [
        ProductModel(title: "The Islands!", descriptionShort: "shortDetail", descriptionLong: "longdetail",imageUrl: "https://www.dreamhost.com/blog/wp-content/uploads/2019/06/afa314e6-1ae4-46c5-949e-c0a77f042e4f_DreamHost-howto-prod-descrips-full.jpeg", price: 18.5),
        ProductModel(title: "The Islands!", descriptionShort: "shortDetail", descriptionLong: "longdetail",imageUrl: "https://www.dreamhost.com/blog/wp-content/uploads/2019/06/afa314e6-1ae4-46c5-949e-c0a77f042e4f_DreamHost-howto-prod-descrips-full.jpeg", price: 18.5),
        ProductModel(title: "The Islands!", descriptionShort: "shortDetail", descriptionLong: "longdetail",imageUrl: "https://www.dreamhost.com/blog/wp-content/uploads/2019/06/afa314e6-1ae4-46c5-949e-c0a77f042e4f_DreamHost-howto-prod-descrips-full.jpeg", price: 18.5),
        ProductModel(title: "The Islands!", descriptionShort: "shortDetail", descriptionLong: "longdetail",imageUrl: "https://www.dreamhost.com/blog/wp-content/uploads/2019/06/afa314e6-1ae4-46c5-949e-c0a77f042e4f_DreamHost-howto-prod-descrips-full.jpeg", price: 18.5),ProductModel(title: "The Islands!", descriptionShort: "shortDetail", descriptionLong: "longdetail",imageUrl: "https://www.dreamhost.com/blog/wp-content/uploads/2019/06/afa314e6-1ae4-46c5-949e-c0a77f042e4f_DreamHost-howto-prod-descrips-full.jpeg", price: 18.5),
          ]
}
 
*/
