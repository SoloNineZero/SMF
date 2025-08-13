import Foundation
import Alamofire

final class PostsViewModel {

    var onPostsUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private(set) var postsWithAuthor: [PostWithAuthor] = []
    private var posts: [Post] = []
    private var users: [User] = []
    
    func numberOfPosts() -> Int {
        postsWithAuthor.count
    }
    
    func loadData() {
        fetchPosts()
        fetchUsers()
    }
    
    private func fetchPosts() {
        NetworkService.shared.fetchData(from: APIEndpoint.posts) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self?.posts = posts
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
            }
        }
    }
    
    private func fetchUsers() {
        NetworkService.shared.fetchData(from: APIEndpoint.users) { [weak self] (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.downloadAvatars(for: users)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
            }
        }
    }
    
    private func downloadAvatars(for users: [User]) {
        var usersWithAvatars = users
        let group = DispatchGroup()
        
        for (index, user) in users.enumerated() {
            guard let url = user.avatarURL else { continue }
            group.enter()
            AF.request(url).responseData { response in
                if case .success(let data) = response.result {
                    usersWithAvatars[index].avatar = data
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.users = usersWithAvatars
            self?.updatePostsWithAuthor()
        }
    }
 
    private func updatePostsWithAuthor() {
        guard !posts.isEmpty, !users.isEmpty else { return }
        
        postsWithAuthor = posts.map({ post in
            let author = users.first { $0.id == post.userId }
            return PostWithAuthor(post: post, author: author)
        })
        
        onPostsUpdate?()
    }
}
