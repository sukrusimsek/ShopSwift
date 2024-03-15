//
//  ViewController.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 14.03.2024.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func configureVC()
    
}


class HomeView: UIViewController {
    
    private let viewModel = HomeViewModel()
    var products = [ShopSwiftElement]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}

extension HomeView: HomeViewInterface {
    func configureVC() {
        view.backgroundColor = .systemBrown
    }
}
