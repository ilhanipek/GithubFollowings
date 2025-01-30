//
//  UserInfoVC.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 15.03.2024.
//

import UIKit

class UserInfoVC: UIViewController {

  var username: String!

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground

    let doneButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }

  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
