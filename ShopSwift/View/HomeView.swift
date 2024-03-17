//
//  ViewController.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 14.03.2024.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadData()
    
}


class HomeView: UIViewController {
    
    private let viewModel = HomeViewModel()
    var collectionViewForHomePage: UICollectionView!
    var products = [ShopSwiftElement]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}

extension HomeView: HomeViewInterface, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func configureVC() {
        
    }
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionViewForHomePage = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionViewForHomePage.delegate = self
        collectionViewForHomePage.dataSource = self
        collectionViewForHomePage.translatesAutoresizingMaskIntoConstraints = false
        collectionViewForHomePage.backgroundColor = UIColor(rgb: 0x884A39)
        collectionViewForHomePage.layer.cornerRadius = 16
        collectionViewForHomePage.isPagingEnabled = true
        collectionViewForHomePage.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionViewForHomePage)
        NSLayoutConstraint.activate([
            collectionViewForHomePage.topAnchor.constraint(equalTo: view.topAnchor),
            collectionViewForHomePage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewForHomePage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewForHomePage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionViewForHomePage.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: view.frame.height/1.25)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        let product = viewModel.products[indexPath.item]
        cell.setupCell(product)
        return cell
    }
    
    
}
