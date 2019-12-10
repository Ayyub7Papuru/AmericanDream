//
//  TranslateService.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 04/12/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

class TranslateService {
    
    
    var sessionTranslation: URLSession
    var task: URLSessionTask?
    
    init(sessionTranslation: URLSession = URLSession(configuration: .default)) {
        self.sessionTranslation = sessionTranslation
    }
    
    func translateText(text: String, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "q=" + text
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    func translationRequest(text: String, callback: @escaping (Bool, TranslateData?) -> Void) { //Formater string pour le navigateur avec url
        guard let translateURL = URL(string: "https://translation.googleapis.com/language/translate/v2") else { return }
        
       
        task?.cancel()
        
        task = sessionTranslation.dataTask(with: translateURL, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            print(data)
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(TranslateData?.self, from: data) else {
                callback(false, nil)
                return
            }
            
            callback(true, responseJSON.self)
        })
        
        task?.resume()

    }

}
