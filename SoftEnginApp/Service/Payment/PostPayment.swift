//
//  PostPayment.swift
//  SoftEnginApp
//
//  Created by Cem Sertkaya on 10.01.2022.
//

import Foundation

class PostPayment
{
    static let shared = PostPayment()
    
    private init() {}
    
    func postPayment(payment : Payment,completionBlock: @escaping (Bool,String?) -> Void) -> Void
    {
        let encoder = JSONEncoder()
        
        if let jsonData = try? encoder.encode(payment)
        {
            if let jsonString = String(data: jsonData, encoding: .utf8)
            {
                CoreData.shared.getAuthObject { auth in
                    
                    let request = ServiceManager.shared.createRequest(token: (auth?.token!)!, url: "transactionRecords/create", body: jsonString, httpMethod: HttpMethod.post)
                    print(jsonString)
                    ServiceManager.shared.dataTask(request: request) { (data,json, response) in
                        
                        if response.getStatusCode() == 200
                        {
                            completionBlock(true,nil)
                        }
                        else
                        {
                            let error = json!["Error"] as! NSArray
                            completionBlock(false, error[0] as! String )
                        }
                    }
                    
                    
                    
                }
                
            }
        }
    }
}
