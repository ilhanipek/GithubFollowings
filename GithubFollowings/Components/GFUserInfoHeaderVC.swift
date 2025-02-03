//
//  GFUserInfoHeaderVCViewController.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 31.01.2025.
//

import UIKit

protocol GFUserInfoHeaderDataSource: AnyObject {
  func fetchAvatarUrl(to source: GFUserInfoHeaderVC) -> String?
}

class GFUserInfoHeaderVC: UIViewController {

  var avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34, fontWeight: .bold)
  let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
  var locationImageView = UIImageView()
  let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
  let bioLabel = GFBodyLabel(textAlignment: .left)

  var user: User!
  var avatarUrl: String?

  weak var dataSource: GFUserInfoHeaderDataSource?

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
      layoutUI()
      configureUIElements()
      configureAvatarImageDataSource() // Avatar URL'yi almak için ekledik
  }

  private func addSubviews() {
    addSubviews(uiViews: [
      avatarImageView,
      usernameLabel,
      nameLabel,
      locationImageView,
      locationLabel,
      bioLabel
    ])
  }

  private func layoutUI() {
    let padding: CGFloat = 20
    let textImagePadding: CGFloat = 12
    
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      avatarImageView.widthAnchor.constraint(equalToConstant: 90),
      avatarImageView.heightAnchor.constraint(equalToConstant: 90),

      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
      usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 38),

      nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),

      locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
      locationImageView.widthAnchor.constraint(equalToConstant: 20),
      locationImageView.heightAnchor.constraint(equalToConstant: 20),

      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      locationLabel.heightAnchor.constraint(equalToConstant: 20),

      bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
      bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      bioLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  private func configureUIElements() {
    //avatarImageView.downloadImage(from: avatarUrl ?? "")
    usernameLabel.text = user.login
    nameLabel.text = user.name ?? ""
    locationLabel.text = user.location ?? "No Location"
    bioLabel.text = user.bio ?? ""
    bioLabel.numberOfLines = 3
    locationImageView.image = UIImage(systemName: SFSymbols.location)
    locationImageView.tintColor = .black
    locationLabel.tintColor = .secondaryLabel
  }

  private func configureAvatarImageDataSource() {
    guard let dataSource = dataSource else { return }
    avatarImageView.downloadImage(from: dataSource.fetchAvatarUrl(to: self) ?? "")
  }

  public func reloadData() {
    configureAvatarImageDataSource()
  }
}
