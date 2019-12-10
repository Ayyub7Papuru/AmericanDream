//
//  TranslateStruct.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 05/12/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation



// MARK: - Translate
struct TranslateData: Decodable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Decodable {
    let translatedText, detectedSourceLanguage: String
}


//// MARK: - Detection
//struct Detect: Decodable {
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass: Decodable {
//    let detections: [[Detection]]
//}
//
//// MARK: - Detection
//struct Detection: Decodable {
//    let confidence: Int
//    let isReliable: Bool
//    let language: String
//}
