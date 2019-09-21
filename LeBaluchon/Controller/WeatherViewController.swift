//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by SayajinPapuru on 16/09/2019.
//  Copyright © 2019 sayajin papuru. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()

    }
    
    func createSearchBar()  {
        
        let searchBar = UISearchBar()
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Entrez la ville de votre choix..."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }


    

}
