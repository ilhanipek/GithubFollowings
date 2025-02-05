//
//  UserInfoVC.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 15.03.2024.
//

import UIKit

class UserInfoVC: UIViewController {

  var headerView = UIView()
  var itemViewOne = UIView()
  var itemViewTwo = UIView()

  var username: String!
  var avatarUrl: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    layoutUI()
    getUserInfoVC()
  }

  private func getUserInfoVC() {
    HttpClient.shared.getFollowingByUsername(followingUsername: username) { result in
      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          let userInfoHeaderVC = GFUserInfoHeaderVC(user: user)
          userInfoHeaderVC.dataSource = self
          self.add(childVC: userInfoHeaderVC, to: self.headerView)
          userInfoHeaderVC.reloadData()
        }
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", message: "\(error.localizedDescription)", buttonTitle: "OK")
      }
    }
  }

  private func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }

  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  private func getFollowingInfo(username: String) {
    showLoadingView()
  }


  func layoutUI() {
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140

    addSubviews()

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      headerView.heightAnchor.constraint(equalToConstant: 180),

      itemViewOne.topAnchor.constraint(equalTo: headerView.topAnchor,constant: padding),
      itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.topAnchor, constant: padding),
      itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
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
      headerView,
      itemViewOne,
      itemViewTwo
    ])
  }
}

extension UserInfoVC: GFUserInfoHeaderDataSource {
  func fetchAvatarUrl(to source: GFUserInfoHeaderVC) -> String? {
    return avatarUrl
  }
}
