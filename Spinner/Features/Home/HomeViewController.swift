//
//  HomeViewController.swift
//  Spinner
//
//  Created by Asmaa Tarek on 13/09/2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let spinner = SpinnerView()
       spinner.showSpinner(at: self.view)
    
        
    }
}

