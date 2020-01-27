//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 12/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

final class TranslationViewController: UIViewController {
    
    private let translateService = TranslateService()
    private var source = "FR"
    private var target = "EN"
    private var isReversed = false
    
    
    @IBOutlet private weak var entryTextView: UITextView!
    @IBOutlet private weak var translatedLabel: UILabel!
    @IBOutlet private weak var sourceLanguageButton: UIButton!
    @IBOutlet private weak var exchangeLanguageButton: UIButton!
    @IBOutlet private weak var targetLanguageButton: UIButton!
    @IBOutlet private weak var translateActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction private func translateButtonTapped(_ sender: UIButton) {
            translateActivityIndicator.startAnimating()
            sender.isHidden = true
        
        
        translateService.translationRequest(text: entryTextView.text, target: target, source: source) { (result) in

            
            switch result {
            case .success(let translateData):
                DispatchQueue.main.async {
                    self.translateActivityIndicator.stopAnimating()
                    sender.isHidden = false
                    self.translatedLabel.text = translateData.data.translations[0].translatedText
                    
                    
                }
            case .failure(_ ):
                let alert = UIAlertController(title: "No connection", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)            }
        }
    }
    
    @IBAction private func exchangeButtonTapped(_ sender: UIButton) {
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
