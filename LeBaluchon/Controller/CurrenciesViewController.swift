//
//  CurrenciesViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 12/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit


final class CurrenciesViewController: UIViewController {
    
    private  let currencyService = CurrencyService()
    private var rates = [Double]()
    private var ratesNames = [String]()
    private var symbols = [String]() {
        didSet {
            symbols.sort(by: <)
            currenciesPickerView.reloadAllComponents()
        }
    }
    
   private var currenciesNames = [String]()
   private var currency = "AED"
    
    @IBOutlet private weak var moneyAmountTextField: UITextField!
    @IBOutlet private weak var currenciesPickerView: UIPickerView!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet weak var currencyActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSymbols()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction private func convertButton(_ sender: UIButton) {
        currencyActivityIndicator.startAnimating()
        sender.isHidden = true
        
        currencyService.getRates(currency: currency) { (result) in
            
            switch result {
            case .success(let rates):
                DispatchQueue.main.async {
                    self.currencyActivityIndicator.stopAnimating()
                    sender.isHidden = false
                    guard let stringAmount = self.moneyAmountTextField.text else { return }
                    guard let amount = Double(stringAmount) else { return }
                    guard let rate = rates[self.currency] else { return }
                    let result = amount * rate
                    self.resultLabel.text = String("\(result)")
                }
                
            case .failure(_ ):
                let alert = UIAlertController(title: "No connection", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
        }
    }
    
    private func loadDataSymbols() {
        currencyService.getCurrencies { (result) in
            switch result {
            case .success(let currencies):
                self.symbols = currencies
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension CurrenciesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
