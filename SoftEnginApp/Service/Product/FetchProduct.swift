//
//  FetchProduct.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation

class FetchProduct
{
    static let shared = FetchProduct()
    
    private init() {}
    
    func getProduct(completionBlock: @escaping ([Product]) -> Void) -> Void
    {
        
        CoreData.shared.getAuthObject { auth in
            
            let request = ServiceManager.shared.createRequest(token: (auth?.token)!, url: "http://localhost:9191/products/", body: "", httpMethod: HttpMethod.get)
            
            ServiceManager.shared.dataTask(request: request){ (data,json, response) in
                let jsonDecoder = JSONDecoder()
                let products : [Product] = try! jsonDecoder.decode([Product].self, from: data)
                completionBlock(products)
                
            }
        }
        
        
    }
}

