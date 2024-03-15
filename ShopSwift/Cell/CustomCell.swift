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
        label.font = .systemFont(ofSize: 24, weight: .light)
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
        label.font = .systemFont(ofSize: 20, weight: .light)
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
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tappedAddCart), for: .touchUpInside)
        return button
    }()
    @objc func tappedAddCart() {
        print("tappedAddCart")
    }
    private let descriptionProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
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
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

            titleLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            addCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            addCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            addCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            addCartButton.heightAnchor.constraint(equalToConstant: 44),

            descriptionProduct.topAnchor.constraint(equalTo: addCartButton.bottomAnchor, constant: 5),
            descriptionProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionProduct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)

        ])

    }
    func setupCell(_ product: ShopSwiftElement) {
        titleLabel.text = product.title
        guard let imageURL = URL(string: product.image ?? "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg") else {
            return
        }
        loadImage(from: imageURL) { image in
            if let image = image {
                self.productImage.image = image
            } else {
                print("Load Image Error in CustomCell")
            }
        }
        let priceText = product.price != nil ? String(format: "%.2f $", product.price!) : "Ask please"
        priceLabel.text = priceText

        descriptionProduct.text = product.description
        
        
    }
    
}
