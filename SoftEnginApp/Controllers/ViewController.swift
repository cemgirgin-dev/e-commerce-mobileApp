//
//  ViewController.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 6.01.2022.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad()
    {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        CoreData.shared.getAuthObject { auth in
            
            if auth != nil
            {
                DispatchQueue.main.async {self.performSegue(withIdentifier: "home", sender: self)}
            }
            else
            {
                DispatchQueue.main.async {self.performSegue(withIdentifier: "auth", sender: self)}
            }
        }
        
        
        
        
        
        
        
    }


}

