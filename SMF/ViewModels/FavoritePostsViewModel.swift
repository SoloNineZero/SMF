import Foundation
import CoreData

final class FavoritePostsViewModel {
    
    private(set) var posts: [CDPost] = [] {
        didSet { onPostsUpdate?() }
    }
    
    var onPostsUpdate: (() -> Void)?
    
    func loadPosts() {
        posts = CoreDataService.shared.fetchPosts()
    }
    
    // Метод для добавления/удаления поста из избранного
    func toggleFavorite(post: CDPost) {
        CoreDataService.shared.deletePost(post)
        NotificationCenter.default.post(name: .favoritesChanged, object: nil)
        loadPosts()
    }
    
    func numberOfPosts() -> Int { posts.count }
    
    func isFavorite(post: CDPost) -> Bool {
        CoreDataService.shared.isPostSaved(id: Int(post.id))
    }
}
