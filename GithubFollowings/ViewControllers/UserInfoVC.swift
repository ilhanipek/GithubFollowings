//
//  UserInfoVC.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 15.03.2024.
//

import UIKit

class UserInfoVC: UIViewController {

  var headerView = UIView()
  var username: String!
  var avatarUrl: String?

  override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
      let doneButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
      navigationItem.rightBarButtonItem = doneButton
      layoutUI()

      HttpClient.shared.getFollowingByUsername(followingUsername: username) { result in
        switch result {
        case .success(let user):
          DispatchQueue.main.async {
            let userInfoHeaderVC = GFUserInfoHeaderVC(user: user)
            userInfoHeaderVC.dataSource = self // Data source bağlantısını yaptık
            self.add(childVC: userInfoHeaderVC, to: self.headerView)
            userInfoHeaderVC.reloadData() // Data'yı güncelle
          }
        case .failure(let error):
          self.presentGFAlertOnMainThread(title: "Something went wrong", message: "\(error.localizedDescription)", buttonTitle: "OK")
        }
      }
    }
  private func getFollowingInfo(username: String) {
    showLoadingView()
  }

  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  func layoutUI() {
    addSubviews()

    headerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      headerView.heightAnchor.constraint(equalToConstant: 180)
    ])
  }
  
  func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }

  private func addSubviews() {
    addSubviews(uiViews: [
      headerView
    ])
  }
}

extension UserInfoVC: GFUserInfoHeaderDataSource {
  func fetchAvatarUrl(to source: GFUserInfoHeaderVC) -> String? {
    return avatarUrl
  }
}
