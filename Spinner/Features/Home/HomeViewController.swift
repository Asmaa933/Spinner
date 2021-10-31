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
        setupView()
    }
}

//MARK: - Helper Methods
private extension HomeViewController {
    
    func setupView() {
        showSpinner()
        
        /// wait 3 seconds and execute removeSpinner
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
            self?.removeSpinner()
        }
    }
    
    func showSpinner() {
        spinner = SpinnerView(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: 100, height: 100))
        spinner.center = view.center
        view.isUserInteractionEnabled = false
        view.addSubview(spinner)
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.spinner.removeSpinner()
            self.view.isUserInteractionEnabled = true
        }
    }
}
