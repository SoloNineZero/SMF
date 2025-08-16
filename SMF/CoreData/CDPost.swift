import Foundation
import CoreData

@objc(CDPost)
public class CDPost: NSManagedObject {

}

extension CDPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost")
    }

    @NSManaged public var id: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var author: String
}
