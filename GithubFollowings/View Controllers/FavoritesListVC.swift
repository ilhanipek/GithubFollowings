//
//  FavoritesListVC.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 28.01.2024.
//

import UIKit

class FavoritesListVC: UIViewController {
  
  let button = GFButton(backgroundColor: .red, title: "TRY")
    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .systemBackground
      addButton()
    }

  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  func addButton() {
    view.addSubview(button)

    NSLayoutConstraint.activate([
      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
      button.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      button.heightAnchor.constraint(equalToConstant: 50)

    ])
  }
}
