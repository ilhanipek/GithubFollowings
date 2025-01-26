//
//  GFButton.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 29.01.2024.
//

import UIKit

class GFButton: UIButton {
  
  init(backgroundColor: UIColor, title: String) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
