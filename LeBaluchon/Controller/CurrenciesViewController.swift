//
//  CurrenciesViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 12/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit


class CurrenciesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let currencyService = CurrencyService()
    let ratesService = RatesService()
    var rates = [Double]()
    var ratesNames = [String]()
    var symbols = [String]() {
        didSet {
            symbols.sort(by: <)
            currenciesPickerView.reloadAllComponents()
        }
    }
    
    var currenciesNames = [String]()
    var currency = "AED"
    
    @IBOutlet weak var moneyAmountTextField: UITextField!
    @IBOutlet weak var currenciesPickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSymbols()
        
    }
    
    @IBAction func convertButton(_ sender: UIButton) {
        ratesService.getRates(currency: currency) { (success, rates) in
            if success {
                
                guard let rates = rates else { return }
                guard let stringAmount = self.moneyAmountTextField.text else { return }
                guard let amount = Double(stringAmount) else { return }
                guard let rate = rates[self.currency] else { return }
                let result = amount * rate
                self.resultLabel.text = String("\(result)")
    
            }
            
        }
    }


    
   
    
    
    func loadDataSymbols() {
        currencyService.getCurrencies { (result) in
            switch result {
            case .success(let currencies):
                self.symbols = currencies
            case .failure(let error):
                print(error)
            }
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return symbols[row]
    
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currency = symbols[row]
    }
}
