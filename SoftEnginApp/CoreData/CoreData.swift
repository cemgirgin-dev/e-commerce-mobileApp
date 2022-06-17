//
//  CoreData.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation
import CoreData
import UIKit

class CoreData
{
    static let shared = CoreData()
    static var basket = [Product]()
    
    private init() {}

    
    func saveToGlobal(token: String, user : User, id : Int)
    {
        DispatchQueue.main.async
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.newBackgroundContext()
            do
            {
                let auth = NSEntityDescription.insertNewObject(forEntityName: "Authentication", into: context)
                auth.setValue(token, forKey: "token")
                print(token)
                auth.setValue(user.getEmail(), forKey: "email")
                auth.setValue(user.getFirstName() ?? "mahmut", forKey: "firstName")
                auth.setValue(user.getLastName() ?? "tuncer", forKey: "lastName")
                auth.setValue(id, forKey: "id")
                
                do
                {
                    try context.save()
                }
                catch{print("Core Data Saving Error")}
            }
        }
    }
    
    func getAuthObject(completionBlock: @escaping (Authentication?) -> Void) -> Void
    {
        DispatchQueue.main.async
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.newBackgroundContext()
            let fetchRequest = NSFetchRequest<Authentication>(entityName: "Authentication")
            fetchRequest.returnsObjectsAsFaults = false
            do
            {
                let results = try context.fetch(fetchRequest)
                if results.count > 0
                {
                    let result = results.last!
                    result.value(forKey: "token")
                    result.value(forKey: "email")
                    result.value(forKey: "firstName")
                    result.value(forKey: "lastName")
                    result.value(forKey: "id")
                    completionBlock(result)
                }
                else{completionBlock(nil)}
            }
            catch{print("There is a error")}
        }
    }
    
    func deleteAllBasket()
    {
        CoreData.basket.removeAll(keepingCapacity: false)
    }
    
    func addToBasket(product : Product, quantityNew : Int)
    {
        for item in CoreData.basket{
            if item.productId == product.productId
            {
                item.amount! += quantityNew
                return
            }
        }
        product.amount = quantityNew
        CoreData.basket.append(product)
        
    }
    
    func returnBasket() -> [Product]
    {
        return CoreData.basket
    }
    
    func calculateTotalPrice() -> Double
    {
        var price = 0.0
        for item in CoreData.basket
        {
            price += item.price! * Double(item.amount!)
        }
        return price
    }
    
    
    
}
