//
//  CastCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import UIKit
import SDWebImage

class CastCollectionViewCell: UICollectionViewCell {
    
    var cast : Cast? {
        didSet {
            if let _ = cast {
                updateCastInfo()
            }
        }
    }
    
    @IBOutlet weak var ivProfile: UIImageView!
    
    private func updateCastInfo(){
        let posterUrl = MovieAppURL.moviePosterImage(path: cast?.profilePath).asPosterImageURL()
        ivProfile.sd_setImage(with: posterUrl)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
