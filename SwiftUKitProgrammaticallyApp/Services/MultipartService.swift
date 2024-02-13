//
//  MultipartService.swift
//  SwiftUKitProgrammaticallyApp
//
//  Created by ibrahim özçelik on 8.01.2024.
//

import Foundation
import Alamofire

class MultipartService
{
    
    func uploadImageToServer(image: UIImage, fileName: String, productTitle: String, productDescription: String, productPrice: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.05) else {
            completion(.failure(NSError(domain: "ImageUploadError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Couldn't convert image to data"])))
            return
        }

        let base64String = imageData.base64EncodedString()
        let filePath = "\(fileName).jpg"

        let parameters: [String: Any] = [
            "filePath": filePath,
            "file": base64String,
            "fileName": fileName,
            "productTitle": productTitle,
            "productDescription": productDescription,
            "productPrice": productPrice,
            "userId" : LoginViewController.user.id! as Any
        ]

        let url = ConstantVariable.baseUrl + "productImage.php"

        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let result = value as? [String: Any], let message = result["message"] as? String {
                        completion(.success(message))
                    } else {
                        completion(.failure(NSError(domain: "ImageUploadError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }


    
}
