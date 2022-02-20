//
//  ItemCell.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import UIKit
import SwiftUI

class ItemCell: UICollectionViewCell {
    
    private enum Layout {
        static let cellEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let buyButtonContentInsets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 45, bottom: 12, right: 45)
        static let defaultSpacing: CGFloat = 8
        static let imageWidth: CGFloat = 100
        static let buttonCornerRadius: CGFloat = 8
    }
    
    private enum Font {
        static var titleFont: UIFont { .title }
        static var descriptionFont: UIFont { .shortDescription }
        static var priceFont: UIFont { .price }
        static var buyButtonFont: UIFont { .buyButton }
    }
    
    var model: ItemCellModel? {
        didSet {
            updateView()
        }
    }
    
    private let backgroundStackView: UIStackView = {
        $0.axis = .horizontal
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = Layout.contentEdgeInsets
        $0.spacing = Layout.defaultSpacing
        return $0
    }(UIStackView())
    
    private let imageStackView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .top
        return $0
    }(UIStackView())
    
    private let imageView: UIImageView = {
        NSLayoutConstraint.activate([
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1),
            $0.widthAnchor.constraint(equalToConstant: Layout.imageWidth)
        ])
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UIImageView())
    
    private let infoStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = Layout.defaultSpacing
        return $0
    }(UIStackView())
    
    private let titleLabel: UILabel = {
        $0.font = Font.titleFont
        $0.textColor = .foreground
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.font = Font.descriptionFont
        $0.textColor = .secondaryForeground
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let priceLabel: UILabel = {
        $0.font = Font.priceFont
        $0.textColor = .foreground
        $0.textAlignment = .right
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var buyButton: UIButton = {
        $0.layer.cornerRadius = Layout.buttonCornerRadius
        $0.contentEdgeInsets = Layout.buyButtonContentInsets
        $0.titleLabel?.font = Font.buyButtonFont
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension ItemCell {
    
    func onTap(_ closure: @escaping (ItemCellModel) -> Void) {
        onTap = closure
    }
    
    @objc private func tapAction() {
        guard let model = model else { return }
        onTap?(model)
    }
    
    func onBuyTap(_ closure: @escaping (Item) -> Void) {
        onBuyTap = closure
    }
    
    @objc private func buyButtonOnTap() {
        guard let item = model?.item else { return }
        onBuyTap?(item)
    }
    
}

extension ItemCell {
    
    private func setupView() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        contentView.addFilling(backgroundStackView, insets: Layout.cellEdgeInsets) { _ in
            backgroundStackView.addFilling(UIView()) { backgroundView in
                backgroundView.backgroundColor = .white
                backgroundView.layer.cornerRadius = 8
            }
            backgroundStackView.add(imageStackView) { _ in
                imageStackView.add(imageView)
            }
            backgroundStackView.add(infoStackView) { _ in
                infoStackView.add(titleLabel)
                infoStackView.add(descriptionLabel)
                infoStackView.add(SeparatorView(color: .border))
                infoStackView.add(priceLabel)
                infoStackView.add(buyButton)
            }
        }
    }
    
    private func updateView() {
        guard let model = model else { return }
        let item = model.item
        
        imageView.image = item.image
        imageStackView.isHidden = item.image == nil
        
        titleLabel.text = item.name
        
        descriptionLabel.text = item.shortDescription
        descriptionLabel.isHidden = item.shortDescription == nil
        
        priceLabel.text = Self.priceFormatted(item)
    }
    
}

extension ItemCell: SizeCalculatable {
    
    static func size(for model: ItemCellModel, constraintTo size: CGSize) -> CGSize {
        var height: CGFloat = 0
        
        height += Layout.cellEdgeInsets.top
        height += Layout.contentEdgeInsets.top
        
        var constraintSize = size
        constraintSize.width -= Layout.cellEdgeInsets.left + Layout.cellEdgeInsets.right
        constraintSize.width -= Layout.contentEdgeInsets.left + Layout.contentEdgeInsets.right
        
        if model.item.image != nil {
            constraintSize.width -= Layout.defaultSpacing
            constraintSize.width -= Layout.imageWidth
        }
        
        height += ceil(model.item.name.rect(with: constraintSize, font: Font.titleFont).height)
        
        if let description = model.item.shortDescription {
            height += Layout.defaultSpacing
            height += ceil(description.rect(with: constraintSize, font: Font.descriptionFont).height)
        }
        height += Layout.defaultSpacing
        height += SeparatorView.defaultThickness
        height += Layout.defaultSpacing
        height += ceil(priceFormatted(model.item).rect(with: constraintSize, font: Font.priceFont).height)
        height += Layout.defaultSpacing
        height += Layout.buyButtonContentInsets.top
        height += ceil(buyButtonText.rect(with: constraintSize, font: Font.buyButtonFont).height)
        height += Layout.buyButtonContentInsets.bottom
        height += Layout.contentEdgeInsets.bottom
        height += Layout.cellEdgeInsets.bottom
        
        return CGSize(width: size.width, height: height)
    }
    
}

// MARK: - Preview

@available(iOS 13.0, *)
private struct ItemCell_ViewRepresentable: UIViewRepresentable {
    
    @Binding var model: ItemCellModel?
    
    func makeUIView(context: Context) -> ItemCell {
        return ItemCell()
    }
    
    func updateUIView(_ itemCell: ItemCell, context: Context) {
        itemCell.model = model
    }
    
}

@available(iOS 13.0, *)
struct ItemCell_Previews: PreviewProvider {
    
    @State static var model: ItemCellModel? = ItemCellModel(item: Item.compactItem, viewMode: .default)
    
    static var previews: some View {
        ItemCell_ViewRepresentable(model: $model)
            .frame(width: 375, height: 200)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
    
}
