//
//  HomeViewModel.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 14.03.2024.
//

import Foundation
protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    func viewDidLoad()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    var products = [ShopSwiftElement]()
    
    private func getProducts() {
        NetworkManager.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.products = products
                self.view?.reloadData()
                print(products.first!)
            case .failure(let error):
                print("Error getProducts in ViewModel \(error.localizedDescription)")
            }
        }
    }
//    private func getCategoryProduct(category: String) {
//        NetworkManager.shared.getCategoryProduct(category: category) { result in
//            switch result {
//            case .success(let products):
//                self.products = products
//                
//            case .failure(let error):
//                print("Error getCategoryProduct in ViewModel \(error.localizedDescription)")
//            }
//            
//        }
//    }
}

extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        getProducts()
        view?.configureVC()
        view?.configureCollectionView()

    }
}
