//
//  Auth.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation

class User : Codable
{
    private var email : String?
    private var password : String?
    private var firstName: String?
    private var lastName : String?
    

    
    init(email: String, password : String, firstName : String, lastName : String)
    {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(email: String, password : String)
    {
        self.email = email
        self.password = password
    }
    
    func getEmail() -> String {return email!}
    func getFirstName() -> String? {return firstName}
    func getLastName() -> String? {return lastName}
}

