//
//  Devises.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 12/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

class CurrencyService {
    
    private let currenciesURL = URL(string: "http://data.fixer.io/api/symbols?access_key=9954839ad756dc9d57ee72e16510a446")
   
    
    var sessionSymbols: URLSession?
    var task: URLSessionTask?
    
    init(sessionSymbols: URLSession = URLSession(configuration: .default)) {
        self.sessionSymbols = sessionSymbols
    }

    
    func getCurrencies(callback: @escaping (Bool, [String: String]?) -> Void) {
        guard let currenciesURL = currenciesURL else { return }
        
        task?.cancel()
        
        task = sessionSymbols?.dataTask(with: currenciesURL, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            
    
            guard let responseJSON = try? JSONDecoder().decode(Symbols.self, from: data) else {
                callback(false, nil)
                return
            }
            
            
            
            callback(true, responseJSON.symbols)
        })
        task?.resume()
    }

    

}
