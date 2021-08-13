//
//  MovieDetailViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 05/06/2021.
//

import Foundation
import UIKit
import SDWebImage
class MovieDetailViewController : BaseViewController {
    
    @IBOutlet weak var collectionViewTags: UICollectionView!
    @IBOutlet weak var collectionViewCast: UICollectionView!
    @IBOutlet weak var lblMovietTitle: UILabel!
    @IBOutlet weak var lblMovieLength: UILabel!
    @IBOutlet weak var lblPlotSummary: UILabel!
    @IBOutlet weak var lblImdbRating: UILabel!
    @IBOutlet weak var scrollView : PassThruScrollView!
    @IBOutlet weak var ivBackdrop: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var btnBack: UIImageView!
    @IBOutlet weak var navigationBar : UIView!
    @IBOutlet weak var backdropHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var btnPlay: UIImageView!
    @IBOutlet weak var viewHeader: PassThroughEmptyView!
    
    
    @IBAction func onTapGetTicket(_ sender: Any) {
        navigateToMovieTimeScreen()
    }
    
    var movieId : Int? = nil
    
    var movie : MovieDetailVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieTags()
        setupListeners()
        showMovieDetails()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupListeners(){
        btnBack.isUserInteractionEnabled = true
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        btnBack.addGestureRecognizer(backTapGesture)
        scrollView.delegate = self
        
        btnPlay.isUserInteractionEnabled = true
        let playTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapPlay))
        btnPlay.addGestureRecognizer(playTapGesture)
        
    }
    
    @objc func onTapBack(){
        navigateBack()
    }
    
    @objc func onTapPlay(){
        print("I'm tapped!!")
    }
    
    private func updateMovieDetails(movie : MovieDetailVO){
        
        //Runtime
        let runtimeHour = (movie.runtime ?? 0) / 60
        let runtimeMinutes = (movie.runtime ?? 0) % 60
        lblMovieLength.text =  "\(runtimeHour)h \(runtimeMinutes)m"
        
        lblMovietTitle.text = movie.originalTitle
        lblPlotSummary.text = movie.overview
        
        let posterImageUrl = MovieAppURL.moviePosterImage(path: movie.posterPath).asPosterImageURL()
        ivBackdrop.sd_setImage(with: posterImageUrl)
        
        ratingControl.rating = Int(movie.rating ?? 0) / 2
        lblImdbRating.text = "IMDB \(movie.rating ?? 0)"
        
        collectionViewCast.reloadData()
        collectionViewTags.reloadData()
        
        dismissDialog()
    }
    
    private func showMovieDetails(){
        if let id = movieId {
//            self.showLoadingDialog()
            networkAgent.getMovieDetails(movieId: id) { result in
                switch result {
                case .success(let movieDetail):
                    if let movie = movieDetail.data {
                        self.movie = movie
                        self.updateMovieDetails(movie : movie)
                        UserPreference.selectedMovie = movie
                    }
                case .failure(let error):
                    self.showErrorDialog(message : error)
                }
            }
        }
    }
    
    private func setupMovieTags(){
        collectionViewTags.delegate = self
        collectionViewTags.dataSource = self
        collectionViewTags.registerCell(identifier: MovieTagCollectionViewCell.identifier)
        collectionViewCast.delegate = self
        collectionViewCast.dataSource = self
        collectionViewCast.registerCell(identifier: CastCollectionViewCell.identifier)
    }
}

extension MovieDetailViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionViewTags){
            return movie?.genres?.count ?? 0
        }else {
            return movie?.casts?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionViewTags){ // Movie Tags
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTagCollectionViewCell.identifier, for: indexPath)
            as? MovieTagCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.tagName = movie?.genres?[indexPath.item] ?? ""
            return cell
        }else { // Casts
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath)
            as? CastCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let cast = movie?.casts?[indexPath.row] {
                cell.cast = cast
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collectionViewTags){
            return CGSize(width: CGFloat(150), height: CGFloat(collectionView.frame.height))
        }else {
            return CGSize(width: CGFloat(84), height: CGFloat(84))
        }
    }
    
    func widthOfString(text : String, font : UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font : font]
        let textSize = text.size(withAttributes: fontAttributes)
        return textSize.width + 16
    }
}

extension MovieDetailViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navBarThreshold = (CGFloat(320) - navigationBar.frame.height)
        if scrollView.contentOffset.y < 0 {
            backdropHeightConstraint.constant = 350 - (scrollView.contentOffset.y * 0.95)
            self.view.layoutIfNeeded()
        } else if scrollView.contentOffset.y > navBarThreshold {
            navigationBar.backgroundColor = UIColor(named: "color_accent")
            ivBackdrop.alpha = 0
        } else if scrollView.contentOffset.y < navBarThreshold {
            navigationBar.backgroundColor = .clear
            ivBackdrop.alpha = 1
        }
        else {
            backdropHeightConstraint.constant = 350
            self.view.layoutIfNeeded()
        }
    }
}
