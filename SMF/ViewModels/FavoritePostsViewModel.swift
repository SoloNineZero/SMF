import Foundation
import CoreData

final class FavoritePostsViewModel {
    
    private(set) var posts: [CDPost] = [] {
        didSet { onPostsUpdate?() }
    }
    
    var onPostsUpdate: (() -> Void)?
    
    func loadPosts() {
        let fetchRequest: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        do {
            posts = try CoreDataService.shared.context.fetch(fetchRequest)
            onPostsUpdate?()
        } catch {
            print("Ошибка загрузки постов: \(error)")
        }
    }
    
    func toggleFavorite(post: CDPost) {
        CoreDataService.shared.deletePost(post)
        loadPosts()
    }
    
    func numberOfPosts() -> Int { posts.count }
    
    func isFavorite(post: CDPost) -> Bool {
        CoreDataService.shared.isPostSaved(id: Int(post.id))
    }
}
