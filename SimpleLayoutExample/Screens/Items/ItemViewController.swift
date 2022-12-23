//
//  ItemViewController.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 22.05.2021.
//

import UIKit
import SwiftUI

class ItemViewController: UIViewController {
    
    var item: Item {
        didSet {
            updateView()
        }
    }
    
    private let scrollView: UIScrollView = {
        $0.backgroundColor = .white
        $0.keyboardDismissMode = .interactive
        return $0
    }(UIScrollView())
    
    private let imageStackView = HStackView(alignment: .top)
    
    private let imageView: UIImageView = {
        $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1).isActive = true
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.font = .title
        $0.textColor = .foreground
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let descriptionStackView = VStackView(spacing: 16)
    
    private let descriptionLabel: UILabel = {
        $0.font = .standard
        $0.textColor = .foreground
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let priceLabel: UILabel = {
        $0.font = .price
        $0.textColor = .foreground
        $0.textAlignment = .right
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var buyButton: UIButton = {
        $0.layer.cornerRadius = 8
        $0.contentEdgeInsets = .init(top: 12, left: 45, bottom: 12, right: 45)
        $0.titleLabel?.font = .buyButton
        $0.setTitle(Self.buyButtonText, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(color: .callToAction, for: .normal)
        $0.addTarget(self, action: #selector(buyButtonOnTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let otherProductsLabel: UILabel = {
        $0.font = .subtitle
        $0.textColor = .foreground
        $0.numberOfLines = 0
        $0.text = "Other products"
        return $0
    }(UILabel())
    
    private var onTap: ((ItemCellModel) -> Void)?
    private var onBuyTap: ((Item) -> Void)?
    private var onOptionsTap: ((Item) -> Void)?
    
    private let otherProducts = [
        "Dice",
        "Headphones",
        "Jar"
    ]
    
    private class func priceFormatted(_ item: Item) -> String { "\(item.price.currency) \(item.price.amountToPay)" }
    
    private class var buyButtonText: String { "BUY" }
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView()
    }
    
}

extension ItemViewController {
    
    @objc private func buyButtonOnTap() {
        let alert = UIAlertController(title: "Buy", message: "Thank you for trying to buy \"\(item.name)\"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}

extension ItemViewController {
    
    private func setupView() {
        view.addFilling(scrollView) { _ in
            scrollView.addVContent(VStackView()) { contentStackView in
                contentStackView.add(imageStackView) { _ in
                    imageStackView.add(imageView)
                }
                contentStackView.add(VStackView(spacing: 16, insets: .init(top: 16, left: 16, bottom: 16, right: 16))) { infoStackView in
                    infoStackView.add(titleLabel)
                    infoStackView.add(descriptionStackView) { _ in
                        descriptionStackView.add(DividerView(color: .border))
                        descriptionStackView.add(descriptionLabel)
                    }
                    infoStackView.add(DividerView(color: .border))
                    infoStackView.add(priceLabel)
                    infoStackView.add(buyButton)
                }
                contentStackView.add(otherProductsLabel, insets: .init(top: 16, left: 16, bottom: 0, right: 16))
                contentStackView.add(UIScrollView()) { hScroll in
                    hScroll.addHContent(HStackView(spacing: 16), insets: .init(top: 16, left: 16, bottom: 16, right: 16)) { hStackView in
                        for product in otherProducts {
                            if let image = UIImage(named: product) {
                                hStackView.add(UIImageView(image: image)) { imageView in
                                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: image.size.height / image.size.width).isActive = true
                                    imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateView() {
        imageView.image = item.image
        imageStackView.isHidden = item.image == nil
        
        titleLabel.text = item.name
        
        descriptionLabel.text = item.description
        descriptionStackView.isHidden = item.description == nil
        
        priceLabel.text = Self.priceFormatted(item)
    }
    
}

// MARK: - Preview

@available(iOS 13.0, *)
private struct ItemViewController_ViewRepresentable: UIViewRepresentable {
    
    @Binding var item: Item
    
    private let itemViewController: ItemViewController
    
    init(item: Binding<Item>) {
        self._item = item
        self.itemViewController = ItemViewController(item: item.wrappedValue)
    }
    
    func makeUIView(context: Context) -> UIView {
        return itemViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        itemViewController.item = item
    }
    
}

@available(iOS 13.0, *)
struct ItemViewController_Previews: PreviewProvider {
    
    @State static var item: Item = Item.fullItem
    
    static var previews: some View {
        ItemViewController_ViewRepresentable(item: $item)
    }
    
}
