import Alamofire

struct LoginResponse: Decodable {
    let message: String
}
class ServiceManagerPost
{
    func request(parameters : [String: Any], connectionService : String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
       
        let url = ConstantVariable.baseUrl + connectionService
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
}


