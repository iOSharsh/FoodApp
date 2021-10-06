//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Harsh Purohit on 01/09/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var subCategory: String?
    @NSManaged public var selectedQuantity: Int32

}
