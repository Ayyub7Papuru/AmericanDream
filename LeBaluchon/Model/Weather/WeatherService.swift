//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 13/11/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

final class WeatherService {
    
    
    private let sessionWeather: URLSession
    private var task: URLSessionTask?
    
    init(sessionWeather: URLSession = URLSession(configuration: .default)) {
        self.sessionWeather = sessionWeather
    }

    func getWeather(callback: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/group?id=5128581,2972315&units=metric&APPID=2b0978f7eb83aba545a261d96c545f12")  else { return }
        task?.cancel()
        
        task = sessionWeather.dataTask(with: weatherURL, completionHandler: { (data, response, error) in
                
                guard let data = data, error == nil else {
                    callback(.failure(NetWorkError.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(NetWorkError.noResponse))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                    callback(.failure(NetWorkError.noDecode))
                    return
                }
                
                
                callback(.success(responseJSON.self))
        })
        task?.resume()
    }
}
