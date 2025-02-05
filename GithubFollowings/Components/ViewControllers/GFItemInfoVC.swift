//
//  GFItemInfoVC.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 5.02.2025.
//

import UIKit

class GFItemInfoVC: UIViewController {

  let stackView = UIStackView()
  let itemInfoViewLeft = GFItemInfoView()
  let itemInfoViewRight = GFItemInfoView()
  let actionButton = GFButton()

    override func viewDidLoad() {
        super.viewDidLoad()

      configureViewController()

    }

  private func configureViewController() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .systemBackground
  }

  private func layoutUI() {
    
  }
}
