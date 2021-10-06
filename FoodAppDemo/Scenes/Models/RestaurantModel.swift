//
//  RestaurantModel.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 31/08/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import Foundation
import SwiftyJSON


// MARK: - Welcome
struct RestaurantArray{
    var array: [Restaurant]?
    
    init(json:JSON) {
        let arr = json["array"].array
        self.array = arr?.compactMap({ (data) -> Restaurant? in
            return Restaurant.init(json: data)
        })
    }
    
}


struct Restaurant:Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.list?.id == rhs.list?.id
    }
    
    var list:RestaurantList?
    var categorys: [Category]?
    
    init(json:JSON) {
        let data = json["restaurant-info"].dictionaryValue
        self.list = RestaurantList.init(json: JSON.init(data))
       
        let categorys = json["categorys"].array
        self.categorys = categorys?.compactMap({ (data) -> Category? in
            return Category.init(json: data)
        })
    }
    init() {
    }
}

struct RestaurantList {
    var name:String?
    var id:Int?
    var imageUrl:String?

    init(json:JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].intValue
        self.imageUrl = json["imageUrl"].stringValue
    }
}

// MARK: - Category
struct Category{
    var id, name, position: String?
    var menuItems: [MenuItem]?
    
    init(json:JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        self.position = json["position"].stringValue
        let menuArr = json["menu-items"].array
        self.menuItems = menuArr?.compactMap({ (data) -> MenuItem? in
            return MenuItem.init(json: data)
        })
        
    }
    
    init() {
    }
//    enum CodingKeys: String, CodingKey {
//        case id, name, position
//        case menuItems = "menu-items"
//    }
}
