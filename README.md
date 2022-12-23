# SimpleLayout

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat)

Layout your views simply! Without XIBs and Storyboards. Using only UIKit code. Hierarchical structure of SimpleLayout views is easy to read. For best layout try to use UIStackViews whenever possible.

```swift
import SimpleLayout

class ProfileViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        $0.backgroundColor = .white
        $0.keyboardDismissMode = .interactive
        return $0
    }(UIScrollView())
    
    private let topView: UIView = {
        $0.heightAnchor.constraint(equalToConstant: 200).isActive = true
        $0.backgroundColor = .lightGray
        return $0
    }(UIView())
    
    private let avatarImageView: UIImageView = {
        NSLayoutConstraint.activate([
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1),
            $0.widthAnchor.constraint(equalToConstant: 100)
        ])
        $0.image = UIImage(systemName: "person.fill")
        return $0
    }(UIImageView())
    
    private let nameCaptionLabel: UILabel = {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .darkText
        $0.text = "Name:"
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return $0
    }(UILabel())
    
    private let nameTextField: UITextField = {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.border.cgColor
        $0.layer.cornerRadius = 4
        $0.font = .preferredFont(forTextStyle: .body)
        $0.textColor = .darkText
        $0.text = "John"
        return $0
    }(UITextField())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addFilling(scrollView) { _ in
            scrollView.addVContent(VStackView()) { contentStackView in
                contentStackView.add(topView) { _ in
                    topView.addCentering(avatarImageView)
                }
                contentStackView.add(VStackView(spacing: 8, insets: .init(top: 16, left: 16, bottom: 16, right: 16))) { formStackView in
                    formStackView.add(HStackView(spacing: 8)) { nameStackView in
                        nameStackView.add(nameCaptionLabel)
                        nameStackView.add(nameTextField)
                    }
                }
            }
        }
    }
    
}
```
