import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    
    var avatarURL: URL? {
        URL(string: "https://picsum.photos/seed/\(id)/50")
    }
    
    var avatar: Data?
}
