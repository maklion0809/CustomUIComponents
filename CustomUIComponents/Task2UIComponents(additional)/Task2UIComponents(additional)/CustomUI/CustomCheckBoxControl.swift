//
//  CustomCheckBoxControl.swift
//  Task2UIComponents(additional)
//
//  Created by Tymofii (Work) on 18.09.2021.
//

import UIKit

class CustomCheckBoxControl: UIButton {
    
    var checkedImage = UIImage(systemName: "checkmark.circle")
    var unchekedImage = UIImage(systemName: "circle")
    
    var condition: Bool = false {
        didSet {
            setImage(condition ? checkedImage : unchekedImage, for: .normal)
        }
    }
        
    init() {
        super.init(frame: CGRect())
        addTarget(self, action:#selector(buttonClicked), for:.touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    @objc private func buttonClicked() {
        condition.toggle()
    }
    
}
