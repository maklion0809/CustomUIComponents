//
//  ViewController.swift
//  Task2UIComponents(additional)
//
//  Created by Tymofii (Work) on 18.09.2021.
//

import UIKit

final class ViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Configuration
    
    private enum Configuration {
        static let checkBoxPadding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        static let checkBoxSize = CGSize(width: 0, height: 50)
    }
    
    // MARK: - UI element
    
    private lazy var checkBox: CustomCheckBoxControl = {
        let checkBox = CustomCheckBoxControl()
        checkBox.tintColor = .black
        checkBox.condition = false
        checkBox.setTitleColor(.black, for: .normal)
        checkBox.setTitle("Check box", for: .normal)
        checkBox.titleLabel?.font = UIFont(name: "Times New Roman", size: 20)
        
        return checkBox
    }()
    
    private lazy var customizationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Customization", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubview()
        setAutoLayout()
    }
    
    // MARK: - Setting up the subviews
    
    private func setupSubview() {
        view.addSubview(checkBox)
        
        view.addSubview(customizationButton)
        customizationButton.addTarget(self, action: #selector(showCustomizationSheet), for: .touchUpInside)
    }
    
    // MARK: - Setting up the constraints
    
    private func setAutoLayout() {
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkBox.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        customizationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customizationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customizationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Configuration.checkBoxPadding.right),
            customizationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: Configuration.checkBoxPadding.left),
            customizationButton.heightAnchor.constraint(equalToConstant: Configuration.checkBoxSize.height)
        ])
    }
    
    // MARK: - Customization sheet
    
    @objc private func showCustomizationSheet() {
        
        // you can create a reference to the property that you want to access in self, and then pass that reference to the closure.
        
        let checkBox = self.checkBox
        
        // attach image
        
        let alert = UIAlertController(title: "Customization sheet", message: "Select сustomization", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Attach image", style: .default, handler: { [weak self] action in
            self?.chooseImagePicker(source: .photoLibrary)
        }))
        
        // Get the condition
        
        alert.addAction(UIAlertAction(title: "Get the condition", style: .default, handler: { [weak self] action in
            let showConditionAlert = UIAlertController(title: "Condition", message: "\(checkBox.condition)", preferredStyle: .alert)
            showConditionAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(showConditionAlert, animated: true, completion: nil)
        }))
        
        // Set text to right
        
        alert.addAction(UIAlertAction(title: "Set text to right", style: .default, handler: { [weak self] action in
            let setTextAction = UIAlertController(title: "Text", message: "Enter the text", preferredStyle: .alert)
            setTextAction.addTextField(configurationHandler: nil)
            setTextAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            setTextAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                checkBox.setTitle(setTextAction.textFields?.first?.text, for: .normal)
            }))
            
            self?.present(setTextAction, animated: true, completion: nil)
        }))
        
        // Change font
        
        alert.addAction(UIAlertAction(title: "Change font", style: .default, handler: { [weak self] action in
            let changeFont = UIAlertController(title: "Change font", message: "Select a font", preferredStyle: .alert)
            changeFont.addTextField { textField in
                textField.placeholder = "Size font (default size 20)"
                textField.keyboardType = .decimalPad
            }
            changeFont.addAction(UIAlertAction(title: "Roboto", style: .default, handler: { action in
                guard let font = Int(changeFont.textFields?.first?.text ?? "20") else { return }
                checkBox.titleLabel?.font = UIFont(name: "Roboto", size: CGFloat(font))
            }))
            changeFont.addAction(UIAlertAction(title: "Noteworthy", style: .default, handler: { action in
                guard let font = Int(changeFont.textFields?.first?.text ?? "20") else { return }
                checkBox.titleLabel?.font = UIFont(name: "Noteworthy", size: CGFloat(font))
            }))
            
            self?.present(changeFont, animated: true, completion: nil)
        }))
        
        // Resize the check box
        
        alert.addAction(UIAlertAction(title: "Resize the check box", style: .default, handler: { [weak self] action in
            let resizeAction = UIAlertController(title: "Resize", message: "Enter x and y", preferredStyle: .alert)
            resizeAction.addTextField { textField in
                textField.placeholder = "x (default 1)"
            }
            resizeAction.addTextField { textField in
                textField.placeholder = "y (default 1)"
            }
            resizeAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            resizeAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                guard let xScaledBy = Double(resizeAction.textFields?.first?.text ?? "1"), let yScaledBy = Double(resizeAction.textFields?.first?.text ?? "1") else { return }
                UIView.animate(withDuration: 4, delay: 1, options: [.curveEaseOut]) {
                    checkBox.transform = checkBox.transform.scaledBy(x: CGFloat(xScaledBy), y: CGFloat(yScaledBy))
                } completion: { (sucsses) in }
                
            }))
            
            self?.present(resizeAction, animated: true, completion: nil)
        }))
        
        // Cancel
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let receiveImage = info[.editedImage] as? UIImage {
            checkBox.checkedImage  = resizeImage(image: receiveImage, targetHeight: 20)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func resizeImage(image: UIImage, targetHeight: CGFloat) -> UIImage {
        let size = image.size
        let heightRatio = targetHeight / size.height
        let newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

