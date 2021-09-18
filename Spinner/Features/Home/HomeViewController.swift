//
//  HomeViewController.swift
//  Spinner
//
//  Created by Asmaa Tarek on 13/09/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Variables
    private var spinner = SpinnerView()
    private var postsArray = [Post]() {
        didSet {
            removeSpinner()
            reloadTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
    }
}

//MARK: - Helper Methods
private extension HomeViewController {
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        showSpinner()
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if data != nil && error == nil {
                let posts = try? JSONDecoder().decode([Post].self, from: data!)
                self?.postsArray = posts ?? []
            } else {
                self?.showError(error: error?.localizedDescription.description)
            }
        }.resume()
    }
    
    func showSpinner() {
        spinner = SpinnerView(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: 100, height: 100))
        spinner.center = view.center
        tableView.isUserInteractionEnabled = false
        tableView.addSubview(spinner)
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {[weak self] in
            self?.spinner.removeSpinner()
            self?.tableView.isUserInteractionEnabled = true
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showError(error: String?) {
        removeSpinner()
        print(error ?? "")
    }
}

//MARK: - UITableViewDelegate Imp
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(postsArray[indexPath.row].title ?? "")
    }
}

//MARK: - UITableViewDataSource Imp

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = postsArray[indexPath.row].title
      //  cell.detailTextLabel?.text = postsArray[indexPath.row].body
        return cell
    }
    
}
