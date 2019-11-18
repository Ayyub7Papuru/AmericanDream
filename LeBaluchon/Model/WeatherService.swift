//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 13/11/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import Foundation

class WeatherService {
    
    
    var sessionWeather: URLSession?
    var task: URLSessionTask?
    
    init(sessionWeather: URLSession = URLSession(configuration: .default)) {
        self.sessionWeather = sessionWeather
    }
    
    func getNYWeather(city: String, callback: @escaping (Bool, Weather?) -> Void) {
        guard let weatherURL = URL(string: "api.openweathermap.org/data/2.5/weather?q=New York&units=metric&APPID=2b0978f7eb83aba545a261d96c545f12")  else { return }
        
      task?.cancel()
            
            let task = sessionWeather?.dataTask(with: weatherURL, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }
                    print(data)
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }
                    
                    guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                        callback(false, nil)
                        return
                    }
                    
                    callback(true, responseJSON.self)
                }
            })
            task?.resume()
    }
}
