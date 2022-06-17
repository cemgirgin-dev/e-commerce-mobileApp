//
//  ServiceManager.swift
//  SoftEnginApp
//
//  Created by Cem Girgin on 11.06.2022.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
class ServiceManager
{
    static let shared = ServiceManager()
    let jsonDecoder = JSONDecoder()

    
    private init() {}
    
    func createRequest(token : String, url: String, body: String, httpMethod : HttpMethod) -> URLRequest
    {
        var request = URLRequest(url: URL(string: url)!)
        print(url)
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")
        request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpMethod = httpMethod.rawValue
        if body == "" {request.httpBody = Data(String().utf8)}
        else{request.httpBody = Data(body.utf8)}
        print("Request body;" + body)
        return request
        
        
    }
        
    func dataTask(request: URLRequest, completionBlock:@escaping (Data,[String:Any]?,URLResponse) -> Void) -> Void
    {
        let session = URLSession.shared

        session.dataTask(with: request) { (data, response, error) in
        if let response = response {print(response)}
        if let data = data
        {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                if json == nil
                {
                    completionBlock(data,nil,response!)
                }
                else
                {
                    completionBlock(data,json!,response!)
                }
               
            }
            catch
            {
                
                completionBlock(data,nil,response!)
            }
            
            
        }}.resume()
    }
}

extension URLResponse
{
    func getStatusCode() -> Int?
    {
        if let httpResponse = self as? HTTPURLResponse {return httpResponse.statusCode}
        return nil
    }
}
