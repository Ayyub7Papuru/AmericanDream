//
//  Rates.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 05/01/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation

struct Rates: Decodable {
    var success: Bool
    var rates: [String: Double]
}
