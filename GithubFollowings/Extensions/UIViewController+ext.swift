//
//  UIViewController+ext.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 16.02.2024.
//

import UIKit

fileprivate var containerView: UIView!

// Extension for adding UIView array as UIViewController subview and setting translatesAutoresizingMaskIntoConstraints to false 
extension UIViewController {
  func addSubviews(uiViews: [UIView]) {
    uiViews.forEach { view in
      view.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(view)
    }
  }
}

// Alert function for UIViewController
extension UIViewController {
  func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertVCViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }
}

// Extension for showing and dismissing Loading View
extension UIViewController {

  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)

    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0

    UIView.animate(withDuration: 0.25) {
      containerView.alpha = 0.8
    }
    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])

    activityIndicator.startAnimating()
  }

  func dismissLoadingView() {
    DispatchQueue.main.async {
      containerView.removeFromSuperview()
      containerView = nil
    }
  }
}

// Extension for showing EmptyStateView when user doesn't have followings
extension UIViewController {
  func showEmptyStateView(with message: String, in view: UIView) {
    let emptyStateView = GFEmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    view.addSubview(emptyStateView)
  }
}

// Extension for adding UIViewController to another UIViewController's UIView
extension UIViewController {
  func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }
}
