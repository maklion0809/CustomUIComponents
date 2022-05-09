//
//  CustomTextField.swift
//  Task2UIComponents(main)
//
//  Created by Tymofii (Work) on 19.09.2021.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let placeholderLabelPadding = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        static let lineViewSize = CGSize(width: 0, height: 5)
        static let countingCharactersLabelPadding = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: -10)
        static let passwordButtonPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
    }
        
    struct TextFieldStateConfig {
        static var placeholderLabelColor: UIColor = .systemGray3
        static var countingCharactersLabelActiveColor: UIColor = .black
        static var countingCharactersLabelInactiveColor: UIColor = .systemGray5
        static var passwordButtonColor: UIColor = .systemGray
        static var borderTextFieldInactiveColor: CGColor = UIColor.systemGray.cgColor
        static var borderTextFieldActiveColor: CGColor = UIColor.systemGray5.cgColor
        static var lineViewInactiveColor: UIColor = .systemGray
    }
    
    // MARK: - UI element
    
    private lazy var countingCharactersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "0 Chars"
        label.textColor = TextFieldStateConfig.countingCharactersLabelActiveColor
        
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = TextFieldStateConfig.lineViewInactiveColor
        return view
    }()
    
    private lazy var passwordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = TextFieldStateConfig.passwordButtonColor
        button.sizeToFit()
        
        return button
    }()
    
    private lazy var alertController = UIAlertController()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = TextFieldStateConfig.placeholderLabelColor
        label.text = "Card number"
        
        return label
    }()
    
    // MARK: - Variables
        
    var topConstraintPlaceholderLabel: NSLayoutConstraint?
    var centerConstraintPlaceholderLable: NSLayoutConstraint?
        
    var minCountOfCharater: Int = 10
    
    // MARK: - Clusure callback
    
    let didTabMessage: (String)->Void = { message in
        print(message)
    }
    
    // MARK: - Configure TextField
    
    func configureTextField() {
        borderStyle = .line
        font = UIFont.systemFont(ofSize: 20)
        layer.borderWidth = 2
        layer.borderColor = TextFieldStateConfig.borderTextFieldInactiveColor
        clearButtonMode = .always
        clearButtonMode = .whileEditing
        delegate = self
        
        setupSubviews()
        setupAutoLayout()
    }
    
    // MARK: State change functions
    
    private func errorState() {
        setAllComponentsToRed()
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = 3.0
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10, y: center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10, y: center.y))
        layer.add(shake, forKey: "position")
    }
    
    private func setAllComponentsToRed() {
        countingCharactersLabel.textColor = .red
        lineView.backgroundColor = .red
        passwordButton.tintColor = .red
        placeholderLabel.textColor = .red
        layer.borderColor = UIColor.red.cgColor
        tintColor = .red
    }
    
    private func returnThePreviosColor() {
        placeholderLabel.textColor = TextFieldStateConfig.placeholderLabelColor
        countingCharactersLabel.textColor = TextFieldStateConfig.countingCharactersLabelInactiveColor
        passwordButton.tintColor = TextFieldStateConfig.passwordButtonColor
    }
    
    // MARK: - Setting up the subviews
    
    private func setupSubviews() {
        
        // Setting up the subview custom text field
        
        addTarget(self, action: #selector(actionEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(actionEdidtionDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(actionEdidtionChanged), for: .editingChanged)
        
        // Setting up the subview placeholder view
        
        addSubview(placeholderLabel)
        
        // Setting up the subview line view

        addSubview(lineView)
        
        // Setting up the subview counting charactersLabel
        
        addSubview(countingCharactersLabel)
        
        // Setting up the subview password button
        
        addSubview(passwordButton)
        passwordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    // MARK: - Setting up the constraints
    
    private func setupAutoLayout() {
        
        // Setting up the constraints of placeholder lable
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraintPlaceholderLabel = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: Configuration.placeholderLabelPadding.top)
        centerConstraintPlaceholderLable =           placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        centerConstraintPlaceholderLable?.isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Configuration.placeholderLabelPadding.left).isActive = true
        
        // Setting up the constraints of line view
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Configuration.lineViewSize.height)
        ])
        
        // Setting up the constraints of counting characters label
        
        countingCharactersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countingCharactersLabel.bottomAnchor.constraint(equalTo: lineView.bottomAnchor, constant: Configuration.countingCharactersLabelPadding.bottom),
            countingCharactersLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Configuration.countingCharactersLabelPadding.right)
        ])
        
        // Setting up the constraints of password button
        
        passwordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Configuration.passwordButtonPadding.right),
            passwordButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

    }
    
    // MARK: - Action of subviews
    
    @objc private func actionEditingDidBegin() {
        layer.borderColor = TextFieldStateConfig.borderTextFieldActiveColor
        countingCharactersLabel.textColor = TextFieldStateConfig.countingCharactersLabelActiveColor
        layer.borderWidth = 2
    }
    @objc private func actionEdidtionDidEnd() {
        layer.borderColor = TextFieldStateConfig.borderTextFieldInactiveColor
        countingCharactersLabel.textColor = TextFieldStateConfig.countingCharactersLabelInactiveColor
        layer.borderWidth = 1
    }
    @objc private func actionEdidtionChanged() {
        countingCharactersLabel.text = "\(text?.count ?? 0) Chars"
        lineView.layer.backgroundColor = (text?.count ?? 0) >= minCountOfCharater ? UIColor.green.cgColor : UIColor.red.cgColor
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry = !isSecureTextEntry
        passwordButton.setImage(UIImage(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), for: .normal)
        if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
            replace(textRange, withText: text ?? "")
        }
    }
}

// MARK: - TextField delegate

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        didTabMessage("TextField became focused")
        returnThePreviosColor()
        centerConstraintPlaceholderLable?.isActive = false
        topConstraintPlaceholderLabel?.isActive = true
        placeholderLabel.font = UIFont.systemFont(ofSize: 15)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        didTabMessage("Focus lost")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        didTabMessage("Text changed")
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= minCountOfCharater
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTabMessage("Press return")
        if (textField.text?.count ?? 0) == 0 {
            centerConstraintPlaceholderLable?.isActive = true
            topConstraintPlaceholderLabel?.isActive = false
        
            placeholderLabel.font = UIFont.systemFont(ofSize: 20)
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
        if (textField.text?.count ?? 0) < minCountOfCharater {
            errorState()
        }
        textField.resignFirstResponder()
        
        return true
    }

}



