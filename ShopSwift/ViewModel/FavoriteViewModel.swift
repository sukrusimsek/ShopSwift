//
//  FavoriteViewModel.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 18.03.2024.
//

import Foundation

protocol FavoriteViewModelInterface {
    var view: FavoriteViewInterface? { get set }
    func viewDidLoad()
}
final class FavoriteViewModel {
    weak var view: FavoriteViewInterface?
    var products = [ShopSwiftElement]()
    
    private func getCategoryProduct(category: String) {
        NetworkManager.shared.getCategoryProduct(category: category) { result in
            switch result {
            case .success(let products):
                self.products = products
                
            case .failure(let error):
                print("Error getCategoryProduct in ViewModel \(error.localizedDescription)")
            }
            
        }
    }
}

extension FavoriteViewModel: FavoriteViewModelInterface {
    func viewDidLoad() {
        
    }
}
