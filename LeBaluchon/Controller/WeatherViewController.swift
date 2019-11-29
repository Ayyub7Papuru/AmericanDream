//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 16/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let weatherService = WeatherService()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherConditionsLabel: UILabel!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var newyorkWeatherConditionsLabel: UILabel!
    @IBOutlet weak var newyorkWeatherConditionsImageView: UIImageView!
    @IBOutlet weak var newyorkCurrentTempLabel: UILabel!
    @IBOutlet weak var newyorkCityLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Changer format temp et charger les images
            weatherService.getWeather { (success, weatherData) in
                if success {
                
                    guard let weatherData = weatherData else { return }
                    self.newyorkCityLabel.text = weatherData.list[0].name
                    self.newyorkWeatherConditionsLabel.text = weatherData.list[0].weather[0].description
                    self.newyorkCurrentTempLabel.text = String(weatherData.list[0].main.temp) + " °C"
                    self.cityLabel.text = weatherData.list[1].name
                    self.weatherConditionsLabel.text = weatherData.list[1].weather[0].description
                    self.currentTemperatureLabel.text = String(weatherData.list[1].main.temp) + " °C"
                
                }
        }
    
    


    

    }

}
