//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by SayajinPapuru on 05/01/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation

class FakeResponseData {
  static  let responseOK = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
   static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class CurrencyError: Error {}
    let currencyError = CurrencyError()

    class TranslationError: Error {}
    let translationError = TranslationError()
    
    class WeatherError: Error {}
    let weatherError = WeatherError()
    
   static var currencyCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Symbols", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
   static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
   static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let currencyIncorrectData = "error".data(using: .utf8)
    static let translationIncorrectData = "error".data(using: .utf8)
    static let weatherIncorrectData = "error".data(using: .utf8)
}
