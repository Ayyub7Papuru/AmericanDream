//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 16/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    let weatherService = WeatherService()
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherConditionsLabel: UILabel!
    @IBOutlet private weak var weatherConditionImageView: UIImageView!
    @IBOutlet private weak var currentTemperatureLabel: UILabel!
    @IBOutlet private weak var newyorkWeatherConditionsLabel: UILabel!
    @IBOutlet private weak var newyorkWeatherConditionsImageView: UIImageView!
    @IBOutlet private weak var newyorkCurrentTempLabel: UILabel!
    @IBOutlet private weak var newyorkCityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Changer format temp et charger les images
        weatherService.getWeather { (result) in
            
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.newyorkCityLabel.text = weatherData.list[0].name
                    self.newyorkWeatherConditionsLabel.text = weatherData.list[0].weather[0].description
                    self.newyorkCurrentTempLabel.text = String(weatherData.list[0].main.temp) + " °C"
                    self.cityLabel.text = weatherData.list[1].name
                    self.weatherConditionsLabel.text = weatherData.list[1].weather[0].description
                    self.currentTemperatureLabel.text = String(weatherData.list[1].main.temp) + " °C"
                }
                
                
            case .failure(_ ):
                
                let alert = UIAlertController(title: "No connection", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
        }
    }
    
}
