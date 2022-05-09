//
//  CustomTextField.swift
//  Task2UIComponents(main)
//
//  Created by Tymofii (Work) on 19.09.2021.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Configuration
    
    struct TextFieldStateConfig {
        var countingCharactersLabelActiveColor: UIColor = .red
         var countingCharactersLabelInactiveColor: UIColor = .black
         var countingCharactersLabelErrorColor: UIColor = .red

         var borderTextFieldInactiveColor: UIColor = .black
         var borderTextFieldActiveColor: UIColor = .lightGray
         var borderTextFieldErrorColor: UIColor = .red
        
         var lineViewInactiveColor: UIColor = .black
         var lineViewActiveColor: UIColor = .green
         var lineViewErrorColor: UIColor = .red
        
         var placeholderLabelInactiveColor: UIColor = .lightGray
         var placeholderLabelActiveColor: UIColor = .lightGray
         var placeholderLabelErrorColor: UIColor = .red
        
         var passwordButtonInactiveColor: UIColor = .black
         var passwordButtonActiveColor: UIColor = .black
         var passwordButtonErrorColor: UIColor = .red
    }
    
    static var textFieldColorState = TextFieldStateConfig()
    
    func passwordInputConfig(countingCharactersLabelActiveColor: UIColor,
                             countingCharactersLabelInactiveColor: UIColor,
                             countingCharactersLabelErrorColor: UIColor,
                             borderTextFieldInactiveColor: UIColor,
                             borderTextFieldActiveColor: UIColor,
                             borderTextFieldErrorColor: UIColor,
                             lineViewInactiveColor: UIColor,
                             lineViewActiveColor: UIColor,
                             lineViewErrorColor: UIColor,
                             placeholderLabelInactiveColor: UIColor,
                             placeholderLabelActiveColor: UIColor,
                             placeholderLabelErrorColor: UIColor,
                             passwordButtonInactiveColor: UIColor,
                             passwordButtonActiveColor: UIColor,
                             passwordButtonErrorColor: UIColor ) -> TextFieldStateConfig {
        TextFieldStateConfig.init(countingCharactersLabelActiveColor: countingCharactersLabelActiveColor,
            countingCharactersLabelInactiveColor:countingCharactersLabelInactiveColor,
            countingCharactersLabelErrorColor: countingCharactersLabelErrorColor,
            borderTextFieldInactiveColor: borderTextFieldInactiveColor,
            borderTextFieldActiveColor: borderTextFieldActiveColor,
            borderTextFieldErrorColor: borderTextFieldErrorColor,
            lineViewInactiveColor: lineViewInactiveColor,
            lineViewActiveColor: lineViewActiveColor,
            lineViewErrorColor: lineViewErrorColor,
            placeholderLabelInactiveColor: placeholderLabelInactiveColor,
            placeholderLabelActiveColor: placeholderLabelActiveColor,
            placeholderLabelErrorColor: placeholderLabelErrorColor,
            passwordButtonInactiveColor: passwordButtonInactiveColor,
            passwordButtonActiveColor: passwordButtonActiveColor,
            passwordButtonErrorColor: passwordButtonErrorColor)
    }
    
    enum State {
        case error
        case active
        case inactive
        
        var countingCharactersLabelColor: UIColor {
            switch self {
            case .error:
                return CustomTextField.textFieldColorState.countingCharactersLabelErrorColor
            case .active:
                return CustomTextField.textFieldColorState.countingCharactersLabelActiveColor
            case .inactive:
                return CustomTextField.textFieldColorState.countingCharactersLabelInactiveColor
            }
        }
        
        var borderTextFieldColor: UIColor {
            switch self {
            case .error:
                return CustomTextField.textFieldColorState.borderTextFieldErrorColor
            case .active:
                return CustomTextField.textFieldColorState.borderTextFieldActiveColor
            case .inactive:
                return CustomTextField.textFieldColorState.borderTextFieldInactiveColor
            }
        }
        
        var lineViewColor: UIColor {
            switch self {
            case .error:
                return CustomTextField.textFieldColorState.lineViewErrorColor
            case .active:
                return CustomTextField.textFieldColorState.lineViewActiveColor
            case .inactive:
                return CustomTextField.textFieldColorState.lineViewInactiveColor
            }
        }
        
        var passwordButtonColor: UIColor {
            switch self {
            case .error:
                return CustomTextField.textFieldColorState.passwordButtonErrorColor
            case .active:
                return CustomTextField.textFieldColorState.passwordButtonActiveColor
            case .inactive:
                return CustomTextField.textFieldColorState.passwordButtonInactiveColor
            }
        }
        
        var placeholderLabelColor: UIColor {
            switch self {
            case .error:
                return CustomTextField.textFieldColorState.placeholderLabelErrorColor
            case .active:
                return CustomTextField.textFieldColorState.placeholderLabelActiveColor
            case .inactive:
                return CustomTextField.textFieldColorState.placeholderLabelInactiveColor
            }
        }
    }
    
    private enum Configuration {
        static let placeholderLabelPadding = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        static let lineViewSize = CGSize(width: 0, height: 5)
        static let countingCharactersLabelPadding = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: -10)
        static let passwordButtonPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
        static let shiftValueTextField: CGFloat = 10        
    }
    
    
    
    // MARK: - UI element
    
    private lazy var countingCharactersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "0 Chars"
        label.textColor = State.inactive.countingCharactersLabelColor
        
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = State.inactive.lineViewColor
        return view
    }()
    
    private lazy var passwordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = State.inactive.passwordButtonColor
        button.sizeToFit()
        
        return button
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = State.inactive.placeholderLabelColor
        label.text = "Card number"
        
        return label
    }()
    
    // MARK: - Variables
    
    var topConstraintPlaceholderLabel: NSLayoutConstraint?
    var centerConstraintPlaceholderLabel: NSLayoutConstraint?
    
    var minCountOfCharacter: Int = 10
    
    // MARK: - Computed property
    
    var countCharacter: Int {
        guard let count = text?.count else { return 0}
        return count
    }
    
    override var isSecureTextEntry: Bool {
        didSet {
            passwordButton.setImage(UIImage(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), for: .normal)
        }
    }
    
    // MARK: - Closure callback
    
    private let didTabMessage: (String) -> Void = { message in
        print(message)
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: CGRect())
        borderStyle = .line
        font = UIFont.systemFont(ofSize: 20)
        layer.borderWidth = 2
        layer.borderColor = State.inactive.borderTextFieldColor.cgColor
        clearButtonMode = .always
        clearButtonMode = .whileEditing
        delegate = self
        
        setupSubviews()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: State change functions
    
    private func errorState() {
        setAllComponentsToRed()
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = 3.0
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: center.x - Configuration.shiftValueTextField, y: center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: center.x + Configuration.shiftValueTextField, y: center.y))
        layer.add(shake, forKey: "position")
    }
    
    private func setAllComponentsToRed() {
        countingCharactersLabel.textColor = State.error.countingCharactersLabelColor
        lineView.backgroundColor = State.error.lineViewColor
        passwordButton.tintColor = State.error.passwordButtonColor
        placeholderLabel.textColor = State.error.placeholderLabelColor
        layer.borderColor = State.error.borderTextFieldColor.cgColor
    }
    
    private func returnThePreviousColor() {
        placeholderLabel.textColor = State.inactive.placeholderLabelColor
        countingCharactersLabel.textColor = State.inactive.countingCharactersLabelColor
        passwordButton.tintColor = State.inactive.passwordButtonColor
    }
    
    // MARK: - Setting up the subviews
    
    private func setupSubviews() {
        
        addTarget(self, action: #selector(actionEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(actionEditionDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(actionEditionChanged), for: .editingChanged)
        
        addSubview(placeholderLabel)
        addSubview(lineView)
        addSubview(countingCharactersLabel)
        addSubview(passwordButton)
        passwordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    // MARK: - Setting up the constraints
    
    private func setupAutoLayout() {
        
        // Setting up the constraints of placeholder label
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraintPlaceholderLabel = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: Configuration.placeholderLabelPadding.top)
        centerConstraintPlaceholderLabel =           placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        centerConstraintPlaceholderLabel?.isActive = true
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
        layer.borderColor = State.active.borderTextFieldColor.cgColor
        countingCharactersLabel.textColor = State.active.countingCharactersLabelColor
        layer.borderWidth = 2
    }
    
    @objc private func actionEditionDidEnd() {
        layer.borderColor = State.inactive.borderTextFieldColor.cgColor
        countingCharactersLabel.textColor = State.inactive.countingCharactersLabelColor
        layer.borderWidth = 1
    }
    
    @objc private func actionEditionChanged() {
        countingCharactersLabel.text = "\(countCharacter) Chars"
        lineView.layer.backgroundColor = countCharacter >= minCountOfCharacter ? State.active.lineViewColor.cgColor : State.error.lineViewColor.cgColor
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
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
        returnThePreviousColor()
        centerConstraintPlaceholderLabel?.isActive = false
        topConstraintPlaceholderLabel?.isActive = true
        placeholderLabel.font = UIFont.systemFont(ofSize: 15)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
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
        
        return updatedText.count <= minCountOfCharacter
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTabMessage("Press return")
        if countCharacter == 0 {
            centerConstraintPlaceholderLabel?.isActive = true
            topConstraintPlaceholderLabel?.isActive = false
            
            placeholderLabel.font = UIFont.systemFont(ofSize: 20)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
        if countCharacter < minCountOfCharacter {
            errorState()
        }
        textField.resignFirstResponder()
        
        return true
    }
    
}



