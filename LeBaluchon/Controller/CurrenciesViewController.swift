//
//  CurrenciesViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 12/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

class CurrenciesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let currency = CurrencyService()
    let ratesService = RatesService()
    var rates = [Double]()
    var ratesNames = [String]()
    var symbols = [String]()
    var currenciesNames = [String]()
    
    
    @IBOutlet weak var moneyAmountTextField: UITextField!
    @IBOutlet weak var currenciesPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSymbols()
        
    }
    
    @IBAction func convertButton(_ sender: UIButton) {
        ratesService.getRates { (success, rates) in
            if success {
                for (k, v) in rates! {
                    self.rates.append(v)
                    self.ratesNames.append(k)
                }
                print(self.rates)
            }
        }
    }

//    func loadDataRates() {
//        ratesService.getRates { (success, rates) in
//            if success {
//
//                for (key, value) in rates! {
//                    self.ratesNames.append(key)
//                    self.rates.append(value)
//                }
//            }
//        }
//    }
    
    
    func loadDataSymbols() {
        currency.getCurrencies { (success, symbols) in
            if success {
                for (key, value) in symbols! {
                    self.symbols.append(key)
                    self.currenciesNames.append(value)
                }
                DispatchQueue.main.async {
                     self.currenciesPickerView.reloadAllComponents()
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.symbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.symbols[row]
    }
}
