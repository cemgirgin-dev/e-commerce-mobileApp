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
    
    init(userId:Int64,productId:Int64,quantitiy:Int64)
    {
        self.productId = productId
        self.userId = userId
        self.quantity = quantitiy
   
    }

}
