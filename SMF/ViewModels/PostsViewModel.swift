import Foundation

final class PostsViewModel {

    var onPostsUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private(set) var posts: [Post] = []
    
    
    func numberOfPosts() -> Int {
        posts.count
    }
    
    func fetchPosts() {
        NetworkServices.shared.fetchData { [weak self] result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self?.posts = posts
                    self?.onPostsUpdate?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
            }
        }
    }
}
