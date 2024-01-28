//
//  ServiceRequestProtocol.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 28.01.2024.
//

import Foundation

protocol ServiceRequestProtocol
{
    func request(url : String, parameters: [String: Any]?, responseItems:@escaping ([Any])->())
}
