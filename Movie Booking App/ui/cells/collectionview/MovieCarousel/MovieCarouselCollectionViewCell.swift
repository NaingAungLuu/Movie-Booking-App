//
//  MovieCarouselCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 05/06/2021.
//

import UIKit
import SDWebImage

class MovieCarouselCollectionViewCell: UICollectionViewCell {
    
    var movie : MovieListItem? {
        didSet {
            updateMovieDetails()
        }
    }
    
    var index : Int = 0
    var onTapMovie : ((Int) -> Void)?

    @IBOutlet weak var imageMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateMovieDetails()
        setupListeners()
    }
    
    private func setupListeners(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapMoviePoster))
        imageMoviePoster.isUserInteractionEnabled = true
        imageMoviePoster.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func onTapMoviePoster(){
        debugPrint("movie Tapped view item")
        if(onTapMovie != nil){
            onTapMovie!(index)
        }
    }
    
    private func updateMovieDetails(){
        lblMovieName.text = movie?.originalTitle
        lblMovieInfo.text = movie?.releaseDate
        let posterUrl = MovieAppURL.moviePosterImage(path: movie?.posterPath).asPosterImageURL()
        imageMoviePoster.sd_setImage(with: posterUrl)
    }

}
