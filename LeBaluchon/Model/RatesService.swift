//
//  RatesService.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 21/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

class RatesService {
//    private let ratesURL = URL(string: "http://data.fixer.io/api/latest?access_key=9954839ad756dc9d57ee72e16510a446")
   
    var sessionRates: URLSession?
    var task: URLSessionTask?

    init(sessionRates: URLSession = URLSession(configuration: .default)) {
        self.sessionRates = sessionRates
    }
    
    func getRates(currency: String, callback: @escaping (Bool, [String: Double]?) -> Void) {
        guard let ratesURL = URL(string: "http://data.fixer.io/api/latest?access_key=9954839ad756dc9d57ee72e16510a446&base=EUR&symbols=\(currency)") else {return}
        
        task?.cancel()
        
        task = sessionRates?.dataTask(with: ratesURL, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Rates.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                callback(true, responseJSON.rates)
            }
            
        })
        task?.resume()
    }
    
    
}
