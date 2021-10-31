//
//  HomeViewController.swift
//  Spinner
//
//  Created by Asmaa Tarek on 13/09/2021.
//

import UIKit

class HomeViewController: UIViewController {
        
    //MARK: - Variables
    private var spinner = SpinnerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: - Helper Methods
private extension HomeViewController {
    
    func showSpinner() {
        spinner = SpinnerView(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: 100, height: 100))
        spinner.center = view.center
        view.isUserInteractionEnabled = false
        view.addSubview(spinner)
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {[weak self] in
            self?.spinner.removeSpinner()
            self?.view.isUserInteractionEnabled = true
        }
    }
}
