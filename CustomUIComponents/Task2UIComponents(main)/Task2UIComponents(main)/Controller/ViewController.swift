//
//  ViewController.swift
//  Task2UIComponents(main)
//
//  Created by Tymofii (Work) on 16.09.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let customTextFieldPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        static let customTextFieldSize = CGSize(width: 0, height: 75)
    }
    
    // MARK: - UI element
    
    private lazy var customTextField = CustomTextField()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupAutoLayout()
    }
    
    // MARK: - Setting up the subviews
    
    private func setupSubviews() {
        
        CustomTextField.textFieldColorState = customTextField.passwordInputConfig(countingCharactersLabelActiveColor: .gray,
                                                countingCharactersLabelInactiveColor: .black,
                                                countingCharactersLabelErrorColor: .red,
                                                borderTextFieldInactiveColor: .black,
                                                borderTextFieldActiveColor: .gray,
                                                borderTextFieldErrorColor: .red,
                                                lineViewInactiveColor: .black,
                                                lineViewActiveColor: .gray,
                                                lineViewErrorColor: .red,
                                                placeholderLabelInactiveColor: .black,
                                                placeholderLabelActiveColor: .gray,
                                                placeholderLabelErrorColor: .red,
                                                passwordButtonInactiveColor: .black,
                                                passwordButtonActiveColor: .gray,
                                                passwordButtonErrorColor: .red)
        
        view.addSubview(customTextField)
    }
    
    // MARK: - Setting up the constraints
    
    private func setupAutoLayout() {
        customTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Configuration.customTextFieldPadding.right),
            customTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Configuration.customTextFieldPadding.left),
            customTextField.heightAnchor.constraint(equalToConstant: Configuration.customTextFieldSize.height),
        ])
    }
    
}
