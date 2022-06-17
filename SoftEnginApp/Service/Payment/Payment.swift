//
//  Payment.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation

class Payment : Codable
{
    private var customerId : Int
    private var products : [PaymentProduct]
    
    init(customerId : Int, paymentProducts : [PaymentProduct])
    {
        self.customerId = customerId
        self.products = paymentProducts
    }
}

class PaymentProduct : Codable
{
    private var productId : Int
    private var quantity : Int
    
    init(productId : Int, quantity: Int)
    {
        self.productId = productId
        self.quantity = quantity
    }
}
