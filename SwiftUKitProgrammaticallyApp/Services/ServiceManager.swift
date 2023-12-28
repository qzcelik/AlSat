//
//  ServiceManager.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 28.12.2023.
//

import Alamofire

final class ServiceManager
{
    static let sharedService: ServiceManager = ServiceManager()
}

extension ServiceManager
{
    func fetchDataRemoteServer <T> (url: String, onSuccess :@escaping (T) -> (), onError: (AFError) -> ())
    where T:Codable
    {
        AF.request(url, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            guard let model = response.value else { print( response.error as Any ); return}
            onSuccess(model)
        }
    }
}
