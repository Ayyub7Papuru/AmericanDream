//
//  CurrenciesJSON.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 18/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

struct Symbols: Decodable {
    var success: Bool
    var symbols: [String: String]
}
