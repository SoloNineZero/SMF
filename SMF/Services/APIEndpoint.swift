import Foundation

/// Структура с адресами API для получения данных.
///
/// - posts: URL для получения списка постов.
/// - users: URL для получения списка пользователей.
enum APIEndpoint {
    static let posts = "https://jsonplaceholder.typicode.com/posts"
    static let users = "https://jsonplaceholder.typicode.com/users"
}
