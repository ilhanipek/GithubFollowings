//
//  ComponentTestVC.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 5.02.2025.
//

import UIKit

protocol VCTestProtocol {
  var testComponentVC: UIViewController { get }
}

protocol ViewTestProtocol {
  var testComponentView: UIView { get }
}

class ViewControllerTestVC: UIViewController, VCTestProtocol {

  let testView = UIView()
  var testComponentVC: UIViewController

  init(testComponentVC: UIViewController) {
    self.testComponentVC = testComponentVC
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.add(childVC: testComponentVC, to: testView)
    layoutUI()
  }

  private func layoutUI() {
    NSLayoutConstraint.activate([
      testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      testView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}

class ViewTestVC: UIViewController, ViewTestProtocol {

  var testComponentView: UIView
  let padding: CGFloat = 40

  init(testComponentView: UIView) {
    self.testComponentView = testComponentView
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .blue

    layoutUI()
    updateViewSizeToMatchComponent()
    view.layoutIfNeeded()
  }

  private func layoutUI() {
    view.addSubview(testComponentView)
    testComponentView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      testComponentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      testComponentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      testComponentView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: padding),
      testComponentView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -padding)
    ])
  }

  private func updateViewSizeToMatchComponent() {
    view.setNeedsLayout()
    view.layoutIfNeeded()

    let targetSize = testComponentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    preferredContentSize = CGSize(width: targetSize.width + padding, height: targetSize.height + padding)
  }
}

