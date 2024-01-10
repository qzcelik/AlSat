import Alamofire

struct LoginResponse: Decodable {
    let message: String
}

func loginUser(parameters : [String: Any], completion: @escaping (Result<LoginResponse, Error>) -> Void) {
   
    let url = ConstantVariable.baseUrl + "user.php"

    AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
        .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                completion(.success(loginResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}


