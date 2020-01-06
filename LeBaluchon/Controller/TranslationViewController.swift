//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 12/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    let translateService = TranslateService()
    var source = "FR"
    var target = "EN"
    var isReversed = false
   
    
    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var translatedLabel: UILabel!
    @IBOutlet weak var sourceLanguageButton: UIButton!
    @IBOutlet weak var exchangeLanguageButton: UIButton!
    @IBOutlet weak var targetLanguageButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
       
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        translateService.translationRequest(text: entryTextView.text!, target: target, source: source) { (result) in

            switch result {
            case .success(let translateData):
                print(translateData)
                DispatchQueue.main.async {
                    
                    self.translatedLabel.text = translateData.data.translations[0].translatedText
                    
                    
                }
            case .failure(_ ):
                print("error")
            }
        }
    }
    
    @IBAction func exchangeButtonTapped(_ sender: UIButton) {
        isReversed.toggle()
        
        switch isReversed {
        case true:
            sourceLanguageButton.setTitle("English", for: .normal)
            targetLanguageButton.setTitle("French", for: .normal)
            source = "EN"
            target = "FR"
        case false:
            sourceLanguageButton.setTitle("French", for: .normal)
            targetLanguageButton.setTitle("English", for: .normal)
            source = "FR"
            target = "EN"
        }
        
    }
    
    
}

