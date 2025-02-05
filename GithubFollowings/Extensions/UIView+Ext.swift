//
//  UIView+Ext.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 3.02.2025.
//

import UIKit

// Extension for adding UIView array as UIView's subview and setting translatesAutoresizingMaskIntoConstraints to false
extension UIView {
  func addSubviews(uiViews: [UIView]) {
    uiViews.forEach { view in
      view.translatesAutoresizingMaskIntoConstraints = false
      addSubview(view)
    }
  }
}
