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
    var text = "Hello"
   
    
    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var translatedLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
//        translateService.translateText(text: text, url: URL)
        translateService.translationRequest(text: text) { (success, translateData) in
            if success {
                guard let translateData = translateData else { return }
                self.translatedLabel.text = translateData.data.translations[0].translatedText
                
            }
        }
    }
    
}

