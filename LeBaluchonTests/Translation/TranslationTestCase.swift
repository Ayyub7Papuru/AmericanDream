//
//  TranslationTestCase.swift
//  LeBaluchonTests
//
//  Created by SayajinPapuru on 05/01/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class TranslationTestCase: XCTestCase {

    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translation =  TranslateService(sessionTranslation: URLSessionFake(data: nil, response: nil, error: FakeResponseData.TranslationError.self as? Error))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        translation.translationRequest(text: "", target: "", source: "") { (success, translateData) in
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translation =  TranslateService(sessionTranslation: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        translation.translationRequest(text: "", target: "", source: "") { (success, translateData) in
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translation =  TranslateService(sessionTranslation: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        translation.translationRequest(text: "", target: "", source: "") { (success, translateData) in
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translation =  TranslateService(sessionTranslation: URLSessionFake(data: FakeResponseData.translationIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        translation.translationRequest(text: "", target: "", source: "") { (success, translateData) in
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translation =  TranslateService(sessionTranslation: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        translation.translationRequest(text: "", target: "", source: "") { (success, translateData) in
            let translatedText = "Hello"
            XCTAssertTrue(success)
            XCTAssertNotNil(translateData)
            XCTAssertEqual(translatedText, "Hello")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    


}
