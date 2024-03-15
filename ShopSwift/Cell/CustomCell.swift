//
//  CustomCell.swift
//  ShopSwift
//
//  Created by Şükrü Şimşek on 15.03.2024.
//

import UIKit

class CustomCell: UICollectionViewCell {
    private let productImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        label.backgroundColor = UIColor(rgb: 0xC38154)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        label.backgroundColor = UIColor(rgb: 0xC38154)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let addCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = .zero
        button.setTitle("Add Cart", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .red
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(CustomCell.self, action: #selector(tappedAddCart), for: .touchUpInside)
        return button
    }()
    @objc func tappedAddCart() {
        print("tappedAddCart")
    }
    private let descriptionProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .black
        label.backgroundColor = UIColor(rgb: 0xC38154)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupAdd()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAdd() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(productImage)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addCartButton)
        contentView.addSubview(descriptionProduct)
    }
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: contentView.frame.height/2),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/3.25),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            priceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/3.25),
            
            addCartButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            addCartButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5),
            addCartButton.widthAnchor.constraint(equalToConstant: contentView.frame.width/3.25),
            
            descriptionProduct.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionProduct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            
        
        ])
    }
    func setupCell(_ product: ShopSwiftElement) {
        titleLabel.text = product.title
        guard let imageURL = URL(string: product.image ?? "") else {
            return
        }
        loadImage(from: imageURL) { image in
            if let image = image {
                self.productImage.image = image
            } else {
                print("Load Image Error in CustomCell")
            }
        }
        let priceText = String(format: "%.2f $", product.price ?? "Ask please")
        priceLabel.text = priceText
        
        descriptionProduct.text = product.description
        
        
    }
    
}
