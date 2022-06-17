//
//  Product.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation

class Product : Codable
{
    public let productId : Int?
    public let productName : String?
    public let price : Double?
    public var amount : Int?
    public let category: String?

   
    /*
     private Long productId;
     private String productName;
     private String category;
     private Double price;
     private Long amount;
     */

    
    init()
    {
        self.productId = Int()
        self.productName = String()
        self.price = Double()
        self.amount = Int()
        self.category = String()
    }
    
 
}
