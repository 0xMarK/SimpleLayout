//
//  ItemsViewController.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 20.05.2021.
//

import UIKit
import SwiftUI

class ItemsViewController: UIViewController {
    
    private var items: [Item] = Item.items
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        $0.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        $0.minimumLineSpacing = 8
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView: UICollectionView = {
        $0.backgroundColor = .listBackground
        $0.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.className)
        $0.dataSource = self
        $0.delegate = self
        $0.allowsSelection = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Items"
        if #available(iOS 13.0, *) {
            tabBarItem.image = UIImage(systemName: "shippingbox.fill")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

extension ItemsViewController {
    
    private func setupView() {
        view.addFilling(collectionView)
    }
    
}

extension ItemsViewController {
    
    private func configureItemCell(_ cell: ItemCell, indexPath: IndexPath) {
        let item = items[indexPath.row]
        let model = ItemCellModel(item: item, viewMode: .default)
        cell.model = model
        cell.onTap { [weak self] model in
            self?.navigationController?.pushViewController(ItemViewController(item: model.item), animated: true)
        }
        cell.onBuyTap { [weak self] item in
            let alert = UIAlertController(title: "Buy", message: "Thank you for trying to buy \"\(item.name)\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
    
}

extension ItemsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.className, for: indexPath) as? ItemCell else { fatalError() }
        configureItemCell(cell, indexPath: indexPath)
        return cell
    }
    
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset
        let left = sectionInset?.left ?? 0
        let right = sectionInset?.right ?? 0
        let width = collectionView.frame.width - left - right
        let constraintSize = CGSize(width: width, height: CGFloat.infinity)
        let item = items[indexPath.row]
        let model = ItemCellModel(item: item, viewMode: .default)
        return ItemCell.size(for: model, constraintTo: constraintSize)
    }
    
}

// MARK: - Preview

@available(iOS 13.0, *)
private struct ItemsViewController_ViewRepresentable: UIViewRepresentable {
    
    private let itemsViewController: ItemsViewController
    
    init() {
        self.itemsViewController = ItemsViewController()
    }
    
    func makeUIView(context: Context) -> UIView {
        return itemsViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}

@available(iOS 13.0, *)
struct ItemsViewController_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemsViewController_ViewRepresentable()
    }
    
}
