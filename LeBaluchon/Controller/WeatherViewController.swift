//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 16/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    let weatherService = WeatherService()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherConditionsLabel: UILabel!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var newyorkWeatherConditionsLabel: UILabel!
    @IBOutlet weak var newyorkWeatherConditionsImageView: UIImageView!
    @IBOutlet weak var newyorkCurrentTempLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
            weatherService.getNYWeather { (success, weatherData) in
            
            }
        
        }
    
    


    

}
