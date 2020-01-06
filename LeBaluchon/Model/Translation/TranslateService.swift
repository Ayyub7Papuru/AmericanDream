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
    
    
    
    func translationRequest(text: String, target: String, source: String, callback: @escaping (Result<TranslateData, Error>) -> Void) {
        
        guard let textEncoded = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let translateURL = URL(string: "https://www.googleapis.com/language/translate/v2?key=AIzaSyBKuHgCc35F06OCKRw09-yUEjdTbO4lBTw&format=text&q=\(textEncoded)&source=\(source)&target=\(target)") else { return }
        
       
        task?.cancel()
        
        task = sessionTranslation.dataTask(with: translateURL, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(NetWorkError.noData))
                return
            }
            print(data)
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(NetWorkError.noResponse))
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                callback(.failure(NetWorkError.noDecode))
                return
            }
            
            callback(.success(responseJSON.self))
        })
        
        task?.resume()

    }

}
