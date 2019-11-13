//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 13/11/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

class WeatherService {
    
    var sessionRates: URLSession?
    var task: URLSessionTask?
    
    init(sessionRates: URLSession = URLSession(configuration: .default)) {
        self.sessionRates = sessionRates
    }
}
