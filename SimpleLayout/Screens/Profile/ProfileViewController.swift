//
//  ProfileViewController.swift
//  SimpleLayout
//
//  Created by Anton Kaliuzhnyi on 21.05.2021.
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController {
    
    private enum Layout {
        static let defaultSpacing: CGFloat = 8
        static let formEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let avatarSize: CGFloat = 100
        static let cornerRadius: CGFloat = 4
    }
    
    private enum Font {
        static var captionFont: UIFont { .preferredFont(forTextStyle: .caption1) }
        static var font: UIFont { .preferredFont(forTextStyle: .body) }
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
    
    private let topView: UIView = {
        NSLayoutConstraint.activate([
            $0.heightAnchor.constraint(equalToConstant: 200)
        ])
        $0.backgroundColor = .userBackground
        return $0
    }(UIView())
    
    private let avatarImageView: UIImageView = {
        NSLayoutConstraint.activate([
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1),
            $0.widthAnchor.constraint(equalToConstant: Layout.avatarSize)
        ])
        $0.image = UIImage(named: "Key")
        return $0
    }(UIImageView())
    
    private let formStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = Layout.defaultSpacing
        return $0
    }(UIStackView())
    
    private let firstNameCaptionLabel: UILabel = {
        $0.font = Font.captionFont
        $0.textColor = .foreground
        $0.text = "First name:"
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return $0
    }(UILabel())
    
    private let firstNameTextField: UITextField = {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.border.cgColor
        $0.layer.cornerRadius = Layout.cornerRadius
        $0.font = Font.font
        $0.textColor = .foreground
        $0.text = "John"
        return $0
    }(UITextField())
    
    private let lastNameCaptionLabel: UILabel = {
        $0.font = Font.captionFont
        $0.textColor = .foreground
        $0.text = "Last name:"
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return $0
    }(UILabel())
    
    private let lastNameTextField: UITextField = {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.border.cgColor
        $0.layer.cornerRadius = Layout.cornerRadius
        $0.font = Font.font
        $0.textColor = .foreground
        $0.text = "Doe"
        return $0
    }(UITextField())
    
    private let aboutCaptionLabel: UILabel = {
        $0.font = Font.captionFont
        $0.textColor = .foreground
        $0.text = "About:"
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return $0
    }(UILabel())
    
    private let aboutTextView: UITextView = {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.border.cgColor
        $0.layer.cornerRadius = Layout.cornerRadius
        $0.isScrollEnabled = false
        $0.font = Font.font
        $0.textColor = .foreground
        $0.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi dictum commodo nulla eget cursus. Etiam gravida rutrum dui, at placerat est facilisis non. Fusce tincidunt elit et quam varius, in interdum nunc ultrices. Nulla ipsum dolor, sodales non urna vel, mollis congue neque. Curabitur eget aliquam quam, congue porta elit. Praesent quis consectetur tellus, varius gravida purus. Phasellus sagittis bibendum nulla, non volutpat eros ornare eget.\nPhasellus accumsan risus ut erat accumsan, at fermentum nibh tincidunt. Praesent elit neque, vehicula nec commodo vitae, vestibulum vitae leo. Vivamus sed tempus erat, at mollis urna. In iaculis quis tellus a egestas. Nunc ultricies risus ipsum, a elementum lectus pellentesque vel. Proin dapibus finibus tincidunt. Quisque eget erat sit amet eros hendrerit egestas vel consectetur libero. Duis id risus augue."
        return $0
    }(UITextView())
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Profile"
        if #available(iOS 13.0, *) {
            tabBarItem.image = UIImage(systemName: "person.fill")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView()
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
}

extension ProfileViewController {
    
    private func setupView() {
        view.addFilling(scrollView) { _ in
            scrollView.add(contentStackView) { _ in
                contentStackView.snap(to: scrollView.contentLayoutGuide)
                contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
                contentStackView.add(topView) { _ in
                    topView.addCentering(avatarImageView)
                }
                contentStackView.add(formStackView, insets: Layout.formEdgeInsets) { _ in
                    formStackView.add(UIStackView()) { firstNameStackView in
                        firstNameStackView.spacing = Layout.defaultSpacing
                        firstNameStackView.add(firstNameCaptionLabel)
                        firstNameStackView.add(firstNameTextField)
                    }
                    formStackView.add(UIStackView()) { lastNameStackView in
                        lastNameStackView.spacing = Layout.defaultSpacing
                        lastNameStackView.add(lastNameCaptionLabel)
                        lastNameStackView.add(lastNameTextField)
                    }
                    formStackView.add(UIStackView()) { aboutStackView in
                        aboutStackView.axis = .vertical
                        aboutStackView.spacing = Layout.defaultSpacing
                        aboutStackView.add(aboutCaptionLabel)
                        aboutStackView.add(aboutTextView)
                    }
                }
            }
        }
    }
    
    private func updateView() {
        if #available(iOS 13.0, *) {
            avatarImageView.image = UIImage(systemName: "person.fill")
        }
    }
    
}

extension ProfileViewController {
    
    @objc private func adjustForKeyboard(notification: Notification) {
        var adjustedHeight: CGFloat = 0
        if notification.name == UIResponder.keyboardWillShowNotification,
            let keyboardValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) {
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            adjustedHeight = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
        }
        let firstScrollView = view.subviews.first { $0 is UIScrollView } as? UIScrollView
        firstScrollView?.contentInset.bottom = adjustedHeight
        firstScrollView?.verticalScrollIndicatorInsets.bottom = adjustedHeight
    }
    
}

// MARK: - Preview

@available(iOS 13.0, *)
private struct ProfileViewController_ViewRepresentable: UIViewRepresentable {
    
    private let profileViewController: ProfileViewController
    
    init() {
        self.profileViewController = ProfileViewController()
    }
    
    func makeUIView(context: Context) -> UIView {
        return profileViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}

@available(iOS 13.0, *)
struct ProfileViewController_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileViewController_ViewRepresentable()
    }
    
}
