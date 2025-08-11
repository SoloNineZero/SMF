import Foundation

final class PostsViewModel {

    var onPostsUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private(set) var postsWithAuthor: [PostWithAuthor] = []
    
    private(set) var posts: [Post] = [] {
        didSet { updatePostsWithAuthor() }
    }
    
    private(set) var users: [User] = [] {
        didSet { updatePostsWithAuthor() }
    }
    
    func numberOfPosts() -> Int {
        postsWithAuthor.count
    }
    
    func loadData() {
        fetchPosts()
        fetchUsers()
    }
    
    private func fetchPosts() {
        NetworkServices.shared.fetchData(from: APIEndpoint.posts) { [weak self] (result: Result<[Post], Error>) in
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
        NetworkServices.shared.fetchData(from: APIEndpoint.users) { [weak self] (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
            }
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
