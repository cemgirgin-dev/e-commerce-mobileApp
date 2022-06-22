//
//  Cart.swift
//  SoftEnginApp
//
//  Created by Cem Girgin on 12.06.2022.
//

import Foundation
import UIKit

class CartService
{
    static let coppied = CartService()
    
    private init() {}
    
    func addToCart(product: CartProduct, completionBlock: @escaping (CartProduct,[String:Any]?, URLResponse) -> Void) -> Void
    {
        CoreData.shared.getAuthObject{ auth in
            let encoder = JSONEncoder()
            
            if let jsonData = try? encoder.encode(product)
            {
                
                if let jsonString = String(data: jsonData, encoding: .utf8)
                {
                    let request = ServiceManager.shared.createRequest(token:(auth?.token)!, url: "http://localhost:9191/carts/addProductToCart/", body: jsonString, httpMethod: HttpMethod.post)
                    
                    ServiceManager.shared.dataTask(request: request){ (data, json, response) in
                        
                        completionBlock(product,json,response)
                    }
                }
            }
        }

    }
    
    func makeAlert(titleInput:String, messageInput:String, viewController : UIViewController)//Error method with parameters
    {
            DispatchQueue.main.async{
                let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                let attributedStringTitle = NSAttributedString(string: titleInput, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : UIColor.black])
                let attributedStringMessage = NSAttributedString(string: messageInput, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor : UIColor.black])
                alert.setValue(attributedStringTitle, forKey: "attributedTitle")
                alert.setValue(attributedStringMessage, forKey: "attributedMessage")
                alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor  =  UIColor.white
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                viewController.present(alert, animated:true, completion: nil)
            }
                
    }
    
    func getCart(completionBlock: @escaping (Cart) -> Void) -> Void
    {
        CoreData.shared.getAuthObject{ auth in
           
            let request = ServiceManager.shared.createRequest(token:(auth?.token)!, url: "http://localhost:9191/carts/\(auth!.id)", body: "", httpMethod: HttpMethod.get)
            
            ServiceManager.shared.dataTask(request: request){ (data, json, response) in
                
                let jsonDecoder = JSONDecoder()
                let cart : Cart = try! jsonDecoder.decode(Cart.self, from: data)
                print("BAŞARILI_____________________________________BAŞARILI")
                completionBlock(cart)
            }
        }
            
        

    }
}





