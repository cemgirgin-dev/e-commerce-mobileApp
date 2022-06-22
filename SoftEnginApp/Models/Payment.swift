//
//  Payment.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation

class Payment : Codable
{
    var cardNumber : Int64
    var userId:Int64
    
    init(cardNumber : Int64, userId: Int64)
    {
        self.cardNumber = cardNumber
        self.userId = userId
    }
}

