//
//  Devises.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 12/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

enum NetWorkError: Error {
    case noData
    case noResponse
    case noDecode
}

class CurrencyService {
    
    private let currenciesURL = URL(string: "http://data.fixer.io/api/symbols?access_key=9954839ad756dc9d57ee72e16510a446")
   
    var sessionRates = URLSession(configuration: .default)
    var sessionSymbols = URLSession(configuration: .default)
    init(sessionSymbols: URLSession = URLSession(configuration: .default), sessionRates: URLSession = URLSession(configuration: .default)) {
        self.sessionSymbols = sessionSymbols
        self.sessionRates = sessionRates
    }
    
    var task: URLSessionTask?
    

    
    func getCurrencies(callback: @escaping (Result<[String], Error>) -> Void) {
        guard let currenciesURL = currenciesURL else { return }
        
        task?.cancel()
        
        task = sessionSymbols.dataTask(with: currenciesURL, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.failure(NetWorkError.noData))
                    return
                }
                
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(NetWorkError.noResponse))
                    return
                }
                
                
                guard let responseJSON = try? JSONDecoder().decode(Symbols.self, from: data) else {
                    callback(.failure(NetWorkError.noDecode))
                    return
                }
                
                var symbols = [String]()
                responseJSON.symbols.forEach({ (key, value) in
                    symbols.append(key)
                })
                
                callback(.success(symbols))
            }
            })


        task?.resume()
    }
    
    func getRates(currency: String, callback: @escaping (Bool, [String: Double]?) -> Void) {
        guard let ratesURL = URL(string: "http://data.fixer.io/api/latest?access_key=9954839ad756dc9d57ee72e16510a446&base=EUR&symbols=\(currency)") else {return}
        
        task?.cancel()
        
        task = sessionRates.dataTask(with: ratesURL, completionHandler: { (data, response, error) in
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
