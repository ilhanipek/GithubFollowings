//
//  GFUserInfoHeaderVCViewController.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 31.01.2025.
//

import UIKit

class GFUserInfoHeaderVCViewController: UIViewController {

  let avatarImageView = GFAvatarImageView(frame: .zero)
  let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 34, fontWeight: .bold)
  let secondaryTitle = GFSecondaryTitleLabel(fontSize: 18)
  let locationImageView = UIImageView()
  let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
  let bioLabel = GFBodyLabel(textAlignment: .left)
  
  var user: User!

  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      addSubviews()
    }

  private func addSubviews() {
    addSubviews(uiViews: [
      avatarImageView,
      titleLabel,
      secondaryTitle,
      locationImageView,
      locationLabel,
      bioLabel
    ])
  }
}
