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
    var text = ""
    
   
    
    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var translatedLabel: UILabel!
    @IBOutlet weak var sourceLanguageButton: UIButton!
    @IBOutlet weak var exchangeLanguageButton: UIButton!
    @IBOutlet weak var targetLanguageButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
//        translateService.translateText(text: text, url: URL)
        translateService.translationRequest(text: text, target: "TR", source: "FR") { (success, translateData) in
            if success {
                guard let translateData = translateData else { return }
                DispatchQueue.main.async {
                    self.translatedLabel.text = translateData.data.translations[0].translatedText
                    self.text = self.entryTextView.text
                    self.translatedLabel.reloadInputViews()
                }
                
                
                
            }
        }
    }
    
}

