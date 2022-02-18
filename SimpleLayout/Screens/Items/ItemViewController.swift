//
//  ItemViewController.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 22.05.2021.
//

import UIKit
import SwiftUI

class ItemViewController: UIViewController {
    
    private enum Layout {
        static let contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let buyButtonContentInsets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 45, bottom: 12, right: 45)
        static let defaultSpacing: CGFloat = 16
        static let buttonCornerRadius: CGFloat = 8
    }
    
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
    
    private let contentStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let imageStackView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .top
        return $0
    }(UIStackView())
    
    private let imageView: UIImageView = {
        $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1).isActive = true
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let infoStackView: UIStackView = {
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = Layout.contentEdgeInsets
        $0.spacing = Layout.defaultSpacing
        return $0
    }(UIStackView())
    
    private let titleLabel: UILabel = {
        $0.font = .title
        $0.textColor = .foreground
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let descriptionStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = Layout.defaultSpacing
        return $0
    }(UIStackView())
    
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
        $0.layer.cornerRadius = Layout.buttonCornerRadius
        $0.contentEdgeInsets = Layout.buyButtonContentInsets
        $0.titleLabel?.font = .buyButton
        $0.setTitle(Self.buyButtonText, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(color: .callToAction, for: .normal)
        $0.addTarget(self, action: #selector(buyButtonOnTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private var onTap: ((ItemCellModel) -> Void)?
    private var onBuyTap: ((Item) -> Void)?
    private var onOptionsTap: ((Item) -> Void)?
    
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
            scrollView.add(contentStackView) { _ in
                contentStackView.snap(to: scrollView.contentLayoutGuide)
                contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
                contentStackView.add(imageStackView) { _ in
                    imageStackView.add(imageView)
                }
                contentStackView.add(infoStackView) { _ in
                    infoStackView.add(titleLabel)
                    infoStackView.add(descriptionStackView) { _ in
                        descriptionStackView.add(SeparatorView(color: .border))
                        descriptionStackView.add(descriptionLabel)
                    }
                    infoStackView.add(SeparatorView(color: .border))
                    infoStackView.add(priceLabel)
                    infoStackView.add(buyButton)
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
