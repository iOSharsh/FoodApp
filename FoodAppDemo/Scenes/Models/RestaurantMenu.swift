//
//  RestaurantMenu.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 31/08/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import Foundation
import SwiftyJSON




// MARK: - MenuItem
struct MenuItem{
    var id, name: String?
    var position: Int?
    var menuItemDescription: String?
  //  var images: [JSONAny]?
    var subItems: [SubItem]?
    
    init(json:JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        self.position = json["position"].intValue
        self.menuItemDescription = json["description"].stringValue
        let arr = json["sub-items"].array
        self.subItems = arr?.compactMap({ (data) -> SubItem? in
            return SubItem.init(json: data)
        })
    }

//    enum CodingKeys: String, CodingKey {
//        case id, name, position
//        case menuItemDescription = "description"
//      //  case images
//        case subItems = "sub-items"
//    }
}

// MARK: - SubItem
struct SubItem {
    var id, name: String?
    var position: Int?
    var price: String?
    var quantity: Int?
    var selectedQuantity: Int?
//var cuisineName: CuisineName?
    var categoryName: String?


    
    init(json:JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        self.position = json["position"].intValue
        self.price = json["price"].stringValue
        self.categoryName = json["category_name"].stringValue
        self.quantity = json["quantity"].intValue
        self.selectedQuantity  = json["selectedQuantity"].intValue
    }
    
    init() {
    }
    
    //    enum CodingKeys: String, CodingKey {
    //        case id, name, position, price, consumable
    //        case cuisineName = "cuisine_name"
    //        case categoryName = "category_name"
    //        case discount, tags
    //    }



}
