import Alamofire

/// Сервис для выполнения сетевых запросов и получения декодированных данных.
/// Использует Alamofire для загрузки и парсинга JSON.
final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
        
    /// Выполняет запрос по указанному URLи декодирует ответ в указанный тип.
    /// - Parameters:
    ///     - url: URL для запроса.
    ///     - completion: Замыкание с результатом загрузки (либо данные, типа <T>, либо ошибка).
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
