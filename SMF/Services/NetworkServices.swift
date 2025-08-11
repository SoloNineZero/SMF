import Foundation
import Alamofire

final class NetworkServices {
    
    static let shared = NetworkServices()
    
    private init (){}
        
    func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
