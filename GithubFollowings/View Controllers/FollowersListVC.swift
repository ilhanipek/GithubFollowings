//
//  FollowersListVC.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 9.02.2024.
//

import UIKit

class FollowingListVC: UIViewController {

  enum Section {
    case main
  }

  var userName : String!
  var followings : [Following] = []
  var filteredFollowings : [Following] = []
  var page = 1
  var hasMoreFollowings = true
  var isSearching = false
  var collectionView : UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Following>!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    configureSearchController()
    getFollowings(username: userName, page: 1)
    configureDataSource()
  }

  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.title = userName
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.register(FollowingCell.self, forCellWithReuseIdentifier: "FollowingCell")
  }

  func configureSearchController() {

    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search for a username"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController

  }

  func getFollowings(username : String, page: Int) {
    showLoadingView()
    NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadingView()
      switch result {
      case .success(let followings):
          if followings.count < 12 { self.hasMoreFollowings = false }
          self.followings.append(contentsOf: followings)
          if self.followings.isEmpty {
            DispatchQueue.main.async {
              let message = "This user doesn't have any followings. Tell them to follow"
              self.showEmptyStateView(with: message, in: self.view)
              return
            }
          }
          self.updateData(on: followings)
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Error", message: "\(error.errorMessage)", buttonTitle: "OK")
      }
    }
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section,Following>(collectionView: collectionView, cellProvider: { collectionView, indexPath, following in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowingCell.reuseID, for: indexPath) as! FollowingCell
      cell.set(following: following)
      return cell
    })
  }
  
  func updateData(on followings: [Following]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Following>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followings)
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
}

extension FollowingListVC : UICollectionViewDelegate {

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    
    if offsetY > contentHeight - height {
      guard hasMoreFollowings else { return }
      page += 1
      getFollowings(username: userName, page: page)
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowings : followings
    let following = activeArray[indexPath.item]
    let destVC = UserInfoVC()
    destVC.username = following.login
    let navController = UINavigationController(rootViewController: destVC)
    present(navController, animated: true)
  }
}

extension FollowingListVC : UISearchResultsUpdating, UISearchBarDelegate {

  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
    isSearching = true
    filteredFollowings = followings.filter {$0.login.lowercased().contains(filter.lowercased())}
    updateData(on: filteredFollowings)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    updateData(on: followings)
  }

}
