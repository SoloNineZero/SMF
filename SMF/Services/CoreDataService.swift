import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model") // имя .xcdatamodeld
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Ошибка загрузки Core Data: \(error)")
            }
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Ошибка сохранения: \(error)")
            }
        }
    }
}

extension CoreDataService {
    
    // Сохранение поста
    func savePost(_ postWithAuthor: PostWithAuthor) {
        let cdPost = CDPost(context: context)
        cdPost.id = Int32(postWithAuthor.post.id)
        cdPost.userId = Int32(postWithAuthor.post.userId)
        cdPost.title = postWithAuthor.post.title
        cdPost.body = postWithAuthor.post.body
        cdPost.author = postWithAuthor.author?.name ?? "Аноним"
        print("Пост сохранен \(cdPost)")
        saveContext()
    }
    
    // Получение всех постов
    func fetchPosts() -> [CDPost] {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Ошибка получения постов: \(error)")
            return []
        }
    }
    
    // Удаление поста
    func deletePost(_ post: CDPost) {
        context.delete(post)
        saveContext()
    }
    
    // Проверка: пост уже в CoreData?
    func isPostSaved(id: Int) -> Bool {
        let request: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            return try context.count(for: request) > 0
        } catch {
            print("Ошибка при проверке поста: \(error)")
            return false
        }
    }
}
