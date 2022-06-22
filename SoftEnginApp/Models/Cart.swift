//
//  Cart.swift
//  SoftEnginApp
//
//  Created by Cem Girgin on 22.06.2022.
//

import Foundation

class Cart : Codable{
    var userId:Int64?
    var totalPrice: Double?
    var addedProducts : [AddedProduct]?
}
