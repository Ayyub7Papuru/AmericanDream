//
//  Rates.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 21/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

struct Rates: Decodable {
    var success: Bool
    var rates: [String: Double]
}
