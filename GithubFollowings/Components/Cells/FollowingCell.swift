//
//  FollowingCell.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 19.02.2024.
//

import UIKit

class FollowingCell: UICollectionViewCell {
  static let reuseID = "FollowingCell"

  let avatarImageView = GFAvatarImageView(frame: .zero)
  let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 20, fontWeight: .bold)

  let padding : CGFloat = 8

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(following : Following) {
    userNameLabel.text = following.login
    avatarImageView.downloadImage(from: following.avatarUrl)
  }

  private func configure() {

    addSubview(avatarImageView)
    addSubview(userNameLabel)

    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

      userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      userNameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
