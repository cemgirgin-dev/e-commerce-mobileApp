//
//  CartProduct.swift
//  SoftEnginApp
//
//  Created by Cem Girgin on 13.06.2022.
//

import Foundation

class CartProduct:Encodable
{

    var userId:Int64
    var quantity: Int64
    var productId: Int64
    var price : Double
    var productName : String
    
    init(userId:Int64,productId:Int64,quantity:Int64,price : Double, productName: String)
    {
        self.productId = productId
        self.userId = userId
        self.quantity = quantity
        self.price = price
        self.productName = productName
   
    }

}
