import Foundation
import Alamofire

final class NetworkServices {
    
    static let shared = NetworkServices()
    
    private init (){}
    
    private let postAPI = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchData(completion: @escaping (Result<[Post], Error>) -> Void) {
        AF.request(postAPI).validate().responseDecodable(of: [Post].self) { response in
            switch response.result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
