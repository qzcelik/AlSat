//
//  ServiceManager.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 28.12.2023.
//

import Alamofire

final class ServiceManagerGet
{
    static let sharedService: ServiceManagerGet = ServiceManagerGet()
}

extension ServiceManagerGet
{
    func serviceManagerRequest <T> (url: String, responseItems:@escaping ([T])->()) where T: Codable
    {
        let decoder : JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        AF.request(url).validate(statusCode: 200..<300).responseString(completionHandler: {str in
                print("str", str)
        }).responseDecodable(of: [T].self,decoder: decoder){
            response in
            switch response.result{
            case .success(let items):
                responseItems(items)
            case.failure(let error):
                print("items error",error)
            }
        }
    }

}
