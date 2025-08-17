import Foundation
import CoreData

final class FavoritePostsViewModel {
    
    var posts: [CDPost] = []
    var onPostsUpdate: (() -> Void)?
    
    func numberOfPosts() -> Int {
        posts.count
    }
    
    func loadPosts() {
        let fetchRequest: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        do {
            posts = try CoreDataService.shared.context.fetch(fetchRequest)
        } catch {
            print("Ошибка загрузки постов: \(error)")
        }
    }
}
