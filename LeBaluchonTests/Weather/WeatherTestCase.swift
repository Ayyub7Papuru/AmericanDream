//
//  WeatherTestCase.swift
//  LeBaluchonTests
//
//  Created by SayajinPapuru on 05/01/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class WeatherTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        let weather = WeatherService(sessionWeather: URLSessionFake(data: nil, response: nil, error: FakeResponseData.WeatherError.self as? Error))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        weather.getWeather { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        let weather = WeatherService(sessionWeather: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        weather.getWeather { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        let weather = WeatherService(sessionWeather: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        weather.getWeather { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfCorrectData() {
        let weather = WeatherService(sessionWeather: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        weather.getWeather { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weather = WeatherService(sessionWeather: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        weather.getWeather { (success, weather) in
            let name = "New York"
            let temp = 4.06
            let weatherIncorrectData = "error".data(using: .utf8)!
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
//            XCTAssertEqual(name, WeatherData.init(list: [List.init(weather: [Weather], main: .init(temp: 4.06), name: "New York")]))
        
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    

}
