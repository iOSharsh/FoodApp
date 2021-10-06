//
//  DataBaseHelper.swift
//  ShoppingAppDemo
//
//  Created by Harsh Purohit on 01/09/21.
//  Copyright © 2021 Harsh Purohit. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON


class DataBaseHelper{
    
   static let sharedInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveInDatabase(object:[SubItem])
    {
        
        _ = object.compactMap { (data) -> SubItem in
            
           let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context) as! Product
            product.quantity = Int32(data.quantity ?? 0)
            product.id = data.id ?? ""
            product.name = data.name
            product.price = data.price
            product.subCategory = data.categoryName
            return data
        }
        do {
            try context.save()
        } catch
        {
           print("Error while saving data")
        }
    }
    
    func deleteAllData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \("Product") error :", error)
        }
    }
    func deleteParticularData(id:Int) {
        
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.returnsObjectsAsFaults = false
            let results = try? context.fetch(fetchRequest)
        let resultData = results as! [Product]
            for object in resultData {
                guard let objectData = object as? NSManagedObject else {continue}
                if id == Int(object.id ?? "0"){
                    context.delete(objectData)
                }
            }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    
    func fetchData() -> [Product]{
        var data = [Product]()
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Product")
        
        do{
           data =  try context.fetch(fetchReq) as! [Product]
            
        }catch{
            print("Unable to fetch")
        }
        return data
    }
    
    func updateParticularData(productData:SubItem) {
        
        let data = self.fetchData()
        
        let getData = productData
        
        let finalData = data.compactMap { (obj) -> Product? in
            if (obj.id == getData.id){
                obj.selectedQuantity = Int32(obj.quantity) - Int32(getData.quantity ?? 0)
                obj.quantity = Int32(getData.quantity ?? 0)
                
            }
            
            return obj
        }
        
        do {
            try context.save()
        } catch
        {
           print("Error while saving data")
        }
           
       }
    
    
    func updateParticularItem(productData:SubItem) {
     
     let data = self.fetchData()
     
     let getData = productData
     
     let finalData = data.compactMap { (obj) -> Product? in
         if (obj.id == getData.id){
             obj.quantity = Int32(getData.quantity ?? 0)
             
         }
         
         return obj
     }
     
     do {
         try context.save()
     } catch
     {
        print("Error while saving data")
     }
        
    }
    
    
    
    func dataExists(productData:[String:Any]) -> Bool{
        let data = self.fetchData()
        
        let getData = SubItem.init(json: JSON.init(productData))
        
        let consists = data.contains { (obj) -> Bool in
            
            return (obj.id == getData.id)
        }
        return consists
    }
}
