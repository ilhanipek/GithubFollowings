//
//  GFAvatarImageView.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 19.02.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
  
  let cache = HttpClient.shared.cache
  let placeholderImage = UIImage(named: "gh-logo")

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }

  func downloadImage(from urlString: String) {
    
    let cacheKey = NSString(string: urlString)
    if let image = cache.object(forKey: cacheKey) {
      self.image = image
      return
    }
    
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self else { return }

      if error != nil { return }
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
      guard let data = data else { return }

      guard let image = UIImage(data: data) else { return }
      
      cache.setObject(image, forKey: cacheKey)

      DispatchQueue.main.async {
        self.image = image
      }
    }
    .resume()
  }
}
