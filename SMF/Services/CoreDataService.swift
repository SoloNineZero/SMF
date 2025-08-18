import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки Core Data: \(error)")
            }
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do { try context.save() }
            catch { print("Ошибка сохранения: \(error)") }
        }
    }
    
    // Получение постов
    func fetchPosts() -> [CDPost] {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    // Добавление поста
    func addPost(from post: PostWithAuthor) {
        let cdPost = CDPost(context: context)
        cdPost.id = Int32(post.post.id)
        cdPost.userId = Int32(post.post.userId)
        cdPost.title = post.post.title
        cdPost.body = post.post.body
        cdPost.author = post.author?.name ?? "Аноним"
        cdPost.avatar = post.author?.avatar
        saveContext()
        
        NotificationCenter.default.post(name: .favoritesChanged, object: nil)
    }
    
    // Удаление поста
    func deletePost(_ post: CDPost) {
        context.delete(post)
        saveContext()
    }
    
    // Пост сохранен в БД
    func isPostSaved(id: Int) -> Bool {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return ((try? context.count(for: request)) ?? 0) > 0
    }
    
    // Переключение избранного
    func toggleFavorite(post: PostWithAuthor) {
        if let existing = fetchPosts().first(where: { $0.id == post.post.id }) {
            deletePost(existing)
        } else {
            addPost(from: post)
        }
        // Уведомляем остальные экраны
        NotificationCenter.default.post(name: .favoritesChanged, object: nil)
    }
}
