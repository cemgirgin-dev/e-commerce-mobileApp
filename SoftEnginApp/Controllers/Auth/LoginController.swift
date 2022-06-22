//
//  LoginController.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 6.01.2022.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,target: self, action: #selector(doneButtonTapped))
                
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        emailField.inputAccessoryView = toolbar
        passwordField.inputAccessoryView = toolbar

        // Do any additional setup after loading the view.
    }
    
    @objc func doneButtonTapped() {view.endEditing(true)}

    @IBAction func loginButtonTapped(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        let auth = AuthService.shared
        if !email.isEmpty && !password.isEmpty
        {
            spinner.isHidden = false
            let user = User(email: email , password: password)
            
            auth.login(user: user) { newUser,data, response in
                DispatchQueue.main.sync {self.spinner.isHidden = true}
    
                if response.getStatusCode() == 200
                {
                    CoreData.shared.saveToGlobal(token: data!["token"] as! String, user: user, id: data!["userId"] as! Int)
                    DispatchQueue.main.sync { self.performSegue(withIdentifier: "login", sender: self)}

                }
                else
                {
                    auth.makeAlert(titleInput: "Giriş Yapılamadı", messageInput: "", viewController: self)
                }
            }
        }
        else
        {
            auth.makeAlert(titleInput: "Eksik Giriş", messageInput: "Lütfen tüm alanları doldurunuz.", viewController: self)
        }
    }
    

}
