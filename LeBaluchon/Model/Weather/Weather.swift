//
//  Weather.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 13/11/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

// MARK: - Welcome

struct WeatherData: Decodable {
    let list: [List]
}

// MARK: - List

struct List: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main

struct Main: Decodable {
    let temp: Double
}

// MARK: - Weather

struct Weather: Decodable {
    let description: String
}
