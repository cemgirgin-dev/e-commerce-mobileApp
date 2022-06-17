//
//  Alert.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation
import UIKit

class Alert
{
    static func makeAlert(titleInput:String, messageInput:String, viewController : UIViewController)//Error method with parameters
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
