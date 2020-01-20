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
        
//            let progressHUD = TranslatingPendingView(text: "Translating")
//            self.view.addSubview(progressHUD)
        
        
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

//class TranslatingPendingView: UIVisualEffectView {
//
//    var text: String? {
//        didSet {
//            label.text = text
//        }
//    }
//    DispatchQueue.main.async {
//     let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
//    }
//
//
//    let label: UILabel = UILabel()
//    let blurEffect = UIBlurEffect(style: .light)
//    let vibrancyView: UIVisualEffectView
//
//    init(text: String) {
//        self.text = text
//        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
//        super.init(effect: blurEffect)
//        self.setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.text = ""
//        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
//        super.init(coder: aDecoder)
//        self.setup()
//    }
//
//    func setup() {
//        contentView.addSubview(vibrancyView)
//        contentView.addSubview(activityIndictor)
//        contentView.addSubview(label)
//        activityIndictor.startAnimating()
//    }
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//
//        if let superview = self.superview {
//
//            let width = superview.frame.size.width / 2.3
//            let height: CGFloat = 50.0
//            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
//                                y: superview.frame.height / 2 - height / 2,
//                                width: width,
//                                height: height)
//            vibrancyView.frame = self.bounds
//
//            let activityIndicatorSize: CGFloat = 40
//            activityIndictor.frame = CGRect(x: 5,
//                                            y: height / 2 - activityIndicatorSize / 2,
//                                            width: activityIndicatorSize,
//                                            height: activityIndicatorSize)
//
//            layer.cornerRadius = 8.0
//            layer.masksToBounds = true
//            label.text = text
//            label.textAlignment = NSTextAlignment.center
//            label.frame = CGRect(x: activityIndicatorSize + 5,
//                                 y: 0,
//                                 width: width - activityIndicatorSize - 15,
//                                 height: height)
//            label.textColor = UIColor.gray
//            label.font = UIFont.boldSystemFont(ofSize: 16)
//        }
//    }
//
//    func show() {
//        self.isHidden = false
//    }
//
//    func hide() {
//        self.isHidden = true
//    }
//}

