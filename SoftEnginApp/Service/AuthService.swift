//
//  Auth.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation
import UIKit


class AuthService
{
    static let shared = AuthService()
    
    private init() {}
    
    func register(user : User, completionBlock: @escaping (User,[String:Any],URLResponse) -> Void) -> Void
    {
        let encoder = JSONEncoder()
        
        if let jsonData = try? encoder.encode(user)
        {
            if let jsonString = String(data: jsonData, encoding: .utf8)
            {
                let request = ServiceManager.shared.createRequest(token: "", url: "http://localhost:9191/auth/register", body: jsonString, httpMethod: HttpMethod.post)
                
                ServiceManager.shared.dataTask(request: request) { (data,json, response) in
                    completionBlock(user,json!,response)
                }
            }
        }
    }
    
    func login(user: User, completionBlock: @escaping (User,[String:Any]?, URLResponse) -> Void) -> Void
    {
        let encoder = JSONEncoder()
        
        if let jsonData = try? encoder.encode(user)
        {
            if let jsonString = String(data: jsonData, encoding: .utf8)
            {
                let request = ServiceManager.shared.createRequest(token: "", url: "http://localhost:9191/auth/login", body: jsonString, httpMethod: HttpMethod.post)
                
                ServiceManager.shared.dataTask(request: request){ (data, json, response) in
                    
                    completionBlock(user,json,response)
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
}

