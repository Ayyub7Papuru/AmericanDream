//
//  RatesDisplayViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 21/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

class RatesDisplayViewController: UIViewController {
    

    @IBOutlet weak var ratesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
