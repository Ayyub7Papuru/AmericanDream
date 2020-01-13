//
//  CurrencyServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by SayajinPapuru on 05/01/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//


@testable import LeBaluchon
import XCTest

class CurrencyServiceTestCase: XCTestCase {

    func testGetCurrenciesShouldPostFailedCallbackIfError() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: nil, response: nil, error: FakeResponseData.CurrencyError.self as? Error), sessionRates: URLSessionFake(data: nil, response: nil, error: FakeResponseData.CurrencyError.self as? Error))

        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getCurrencies { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)

}
    
    func testGetRatesShouldPostFailedCallbackIfError() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: nil, response: nil, error: FakeResponseData.CurrencyError.self as? Error), sessionRates: URLSessionFake(data: nil, response: nil, error: FakeResponseData.CurrencyError.self as? Error))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getRates(currency: "") { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetRatesShouldPostFailedCallbackIfNoData() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: nil, response: nil, error: nil), sessionRates: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getRates(currency: "") { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrenciesShouldPostFailedCallbackIfIncorrectResponse() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil), sessionRates: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getCurrencies { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil), sessionRates: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getRates(currency: "") { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrenciesShouldPostFailedCallbackIfIncorrectData() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: FakeResponseData.currencyIncorrectData, response: FakeResponseData.responseOK, error: nil), sessionRates: URLSessionFake(data: FakeResponseData.currencyIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getCurrencies { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: FakeResponseData.currencyIncorrectData, response: FakeResponseData.responseOK, error: nil), sessionRates: URLSessionFake(data: FakeResponseData.currencyIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getRates(currency: "") { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetCurrenciesShouldPostSuccessCallbackIfCorrectDataAndCorrectResponse() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil), sessionRates: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getCurrencies { (result) in
            guard case .success(let results) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(results)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostSuccessCallbackIfCorrectDataAndCorrectResponse() {
        let currencyService = CurrencyService(sessionSymbols: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseOK, error: nil), sessionRates: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        currencyService.getRates(currency: "USD", callback: { (result) in
                guard case .success(let results) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(results)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
}
