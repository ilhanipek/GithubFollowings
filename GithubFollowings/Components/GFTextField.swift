//
//  GFTextField.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 29.01.2024.
//

import UIKit

class GFTextField: UITextField {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure() 
  }

  func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray4.cgColor

    text = "ilhanipek"
    textColor = .label
    tintColor = .label
    textAlignment = .center

    font = UIFont.preferredFont(forTextStyle: .title2)
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 12

    backgroundColor = .tertiarySystemBackground
    keyboardType = .emailAddress
    returnKeyType = .go
    autocorrectionType = .no
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
