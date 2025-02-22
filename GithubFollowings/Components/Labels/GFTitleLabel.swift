//
//  GFTitleLabel.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 12.02.2024.
//

import UIKit

class GFTitleLabel: UILabel {

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  init(textAlignment: NSTextAlignment,fontSize : CGFloat,fontWeight: UIFont.Weight) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    configure()
  }

  private func configure() {
    textColor = .label
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.9
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
