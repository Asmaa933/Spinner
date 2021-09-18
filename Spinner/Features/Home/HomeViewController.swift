//
//  HomeViewController.swift
//  Spinner
//
//  Created by Asmaa Tarek on 13/09/2021.
//

import UIKit

class HomeViewController: UIViewController {
    var spinner = SpinnerView()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        spinner = SpinnerView(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: 100, height: 100))
        spinner.center = view.center
        view.addSubview(spinner)
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.spinner.removeSpinner()
        }
    }
}

