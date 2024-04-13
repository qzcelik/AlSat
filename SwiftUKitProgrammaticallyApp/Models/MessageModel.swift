//
//  MessageModel.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 2.04.2024.
//

import Foundation

struct MessageModel : Codable
{
    var productId : String?
    var userId : String?
    var ownerId : String?
    var message : String?
    var textAlign : String?
}
