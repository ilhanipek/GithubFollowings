//
//  GFItemInfoView.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 3.02.2025.
//

import UIKit

enum ItemInfoType {
  case repos, gists, followers, followings
}

class GFItemInfoView: UIView {

  let symbolImageView = UIImageView()
  let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14, fontWeight: .black)
  let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14, fontWeight: .black)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    addSubviews(uiViews: [
      symbolImageView,
      titleLabel,
      countLabel
    ])
  }

  private func configureLayout() {

    symbolImageView.contentMode = .scaleAspectFill
    symbolImageView.tintColor = .label

    NSLayoutConstraint.activate([
      symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
      symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      symbolImageView.widthAnchor.constraint(equalToConstant: 20),
      symbolImageView.heightAnchor.constraint(equalToConstant: 20),
      
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 20),

      countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: 18)

    ])
  }

  func set(itemInfoType: ItemInfoType, withCount: Int) {
    switch itemInfoType {
    case .repos:
      symbolImageView.image = UIImage(systemName: SFSymbols.repos)
      titleLabel.text = "Public Repos"
    case .gists:
      symbolImageView.image = UIImage(systemName: SFSymbols.gists)
      titleLabel.text = "Public Gists"
    case .followers:
      symbolImageView.image = UIImage(systemName: SFSymbols.followers)
      titleLabel.text = "Followers"
    case .followings:
      symbolImageView.image = UIImage(systemName: SFSymbols.following)
      titleLabel.text = "Followings"
    }
    countLabel.text = String(withCount)
  }
}
