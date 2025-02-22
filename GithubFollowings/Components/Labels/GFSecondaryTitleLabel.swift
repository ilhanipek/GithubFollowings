//
//  GFSecondaryTitleLabel.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 31.01.2025.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(fontSize: CGFloat) {
    super.init(frame: .zero)
    font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    configure()
  }

  private func configure() {
    textColor = .secondaryLabel
    font = UIFont.preferredFont(forTextStyle: .body)
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.90
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
