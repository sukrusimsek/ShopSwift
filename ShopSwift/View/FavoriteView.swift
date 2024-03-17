//
//  FavoriteView.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 16.03.2024.
//

import UIKit
protocol FavoriteViewInterface: AnyObject {
    func configureVC()
}

class FavoriteView: UIViewController {
    var products = [ShopSwiftElement]()
    private let viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}
extension FavoriteView: FavoriteViewInterface {
    func configureVC() {
        
    }
    
}
