//
//  SignUpController.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 6.01.2022.
//

import UIKit

class SignUpController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
 
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var phonenumberField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,target: self, action: #selector(doneButtonTapped))
                
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        nameField.inputAccessoryView = toolbar
        emailField.inputAccessoryView = toolbar
        passwordField.inputAccessoryView = toolbar
        phonenumberField.inputAccessoryView = toolbar
        phonenumberField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField.text?.count == 10 {
            return false
        }
        return true
    }
    
    @objc func doneButtonTapped() {view.endEditing(true)}
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        let firstName = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        let lastName = phonenumberField.text!
        let auth = Auth.shared
        if !firstName.isEmpty && !email.isEmpty && !password.isEmpty && !lastName.isEmpty
        {
            
            spinner.isHidden = false
            let user = User(email: email , password: password, firstName: firstName, lastName: lastName)
            
            auth.register(user: user) { newUser,data, response in
                
                DispatchQueue.main.sync {self.spinner.isHidden = true}
                
                if response.getStatusCode() == 200
                {
                    CoreData.shared.saveToGlobal(token: data["token"] as! String, user: user, id: data["userId"] as! Int)
                    DispatchQueue.main.sync { self.performSegue(withIdentifier: "signup", sender: self)}
                }
                else
                {
                    auth.makeAlert(titleInput: "Giriş Yapılamadı", messageInput:" ", viewController: self)
                }
            }
        }
        else
        {
            auth.makeAlert(titleInput: "Eksik Giriş", messageInput: "Lütfen tüm alanları doldurunuz.", viewController: self)
        }
    }
    
}
