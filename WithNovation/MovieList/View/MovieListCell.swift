//
//  TutorialCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 27/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet fileprivate weak var imageCoverView: UIView!
  @IBOutlet fileprivate weak var titleLabel: UILabel!
  
  var movie: Movie? {
    didSet {
      if let movie = movie {
        titleLabel.text = movie.title
        
        let url = URL(string: movie.image)
        let processor = DownsamplingImageProcessor(size: imageView.frame.size)
            >> RoundCornerImageProcessor(cornerRadius: 0)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success( _):
                break
            case .failure(let error):
                print("failed: \(error.localizedDescription)")
            }
        }
        
      }
    }
  }
  
}
