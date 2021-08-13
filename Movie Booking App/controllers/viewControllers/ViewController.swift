//
//  ViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 29/05/2021.
//

import UIKit
import SDWebImage

class ViewController: BaseViewController {

    @IBOutlet weak var carouselNowShowing: MovieCarousel!
    @IBOutlet weak var carouselComingSoon: MovieCarousel!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblPersonalizedGreeting: UILabel!
    
    var onTapNowShowingMovieDelegate : ((Int) -> Void)?
    var onTapComingSoonMovieDelegate : ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCarouselViews()
        setupNavController()
        setupProfileView()
        showMovieListData()
    }
    
    private func setupProfileView(){
        let userVO = UserPreference.userVO
        
        let profileImageUrl = MovieAppURL.image(path: userVO?.profileImage).asImageURL()
        ivProfile.sd_setImage(with: profileImageUrl , placeholderImage: UIImage(named: "img_profile"))
        
        let greeterText = "Hi \(userVO?.name ?? "")!"
        lblPersonalizedGreeting.text = greeterText
        
    }
    
    private func setupNavController(){
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    private func setupCarouselViews(){
        
        onTapNowShowingMovieDelegate = { index in
            debugPrint("movie Tapped view controller")
            if let movieId = self.carouselNowShowing.movieList?[index].id {
                self.navigateToMovieDetailScreen(id: movieId)
            }
        }
        onTapComingSoonMovieDelegate = { index in
            debugPrint("movie Tapped view controller")
            if let movieId = self.carouselComingSoon.movieList?[index].id {
                self.navigateToMovieDetailScreen(id: movieId)
            }
        }
        
        carouselNowShowing.onTapMovie = onTapNowShowingMovieDelegate
        carouselComingSoon.onTapMovie = onTapComingSoonMovieDelegate
    }
    
    private func showMovieListData() {
        networkAgent.getMovieList(statusType: .CURRENT) { movieListResponse in
            switch movieListResponse {
            case .success(let movieList):
                if let movies = movieList.data {
                    self.carouselNowShowing.movieList = movies
                }
            case .failure(let error):
                self.showErrorDialog(message: error)
            }
        }
        networkAgent.getMovieList(statusType: .COMING_SOON) { movieListResponse in
            switch movieListResponse {
            case .success(let movieList):
                if let movies = movieList.data {
                    self.carouselComingSoon.movieList = movies
                }
            case .failure(let error):
                self.showErrorDialog(message: error)
            }
        }
    }

}

extension ViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
