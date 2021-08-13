//
//  TicketViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import UIKit
import SDWebImage
class TicketViewController : UIViewController {
    
    @IBOutlet weak var viewTicketContainer: UIView!
    @IBOutlet weak var viewTickerStackView: UIStackView!
    @IBOutlet weak var dashLineView: UIView!
    @IBOutlet weak var bottomDashLineView: UIView!
    @IBOutlet weak var lblMovieType: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblBookingNo: UILabel!
    @IBOutlet weak var lblMovieTime: UILabel!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var lblRow: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var ivQRCode: UIImageView!
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var ivMoviePoster: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        drawDottedLine(start: CGPoint(x: dashLineView.bounds.minX, y: dashLineView.bounds.minY), end: CGPoint(x: dashLineView.bounds.maxX, y: dashLineView.bounds.minY), view: dashLineView)
        drawDottedLine(start: CGPoint(x: bottomDashLineView.bounds.minX, y: bottomDashLineView.bounds.minY), end: CGPoint(x: bottomDashLineView.bounds.maxX, y: bottomDashLineView.bounds.minY), view: bottomDashLineView)
        viewTicketContainer.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: CGFloat(0.2), height: CGFloat(0.2)), radius: 10, scale: true)
        setupListeners()
        bindData()
    }
    
    @IBOutlet weak var btnClose: UIImageView!
    
    var ticket : TicketVO?
    
    private func setupListeners(){
        let tapGuestureForBack = UIGestureRecognizer(target: btnClose, action: #selector(onTapBack))
        btnClose.isUserInteractionEnabled = true
        btnClose.addGestureRecognizer(tapGuestureForBack)
    }
    
    private func bindData() {
        if let ticketVO = ticket, let cinema = UserPreference.selectedCinema , let movie = UserPreference.selectedMovie {
            lblMovieType.text = "105m IMAX"
            lblMovieName.text = movie.originalTitle
            lblBookingNo.text = ticketVO.bookingNo
            lblMovieTime.text = ticketVO.timeslot?.startTime
            lblCinemaName.text = cinema.cinema
            lblRow.text = ticketVO.row
            lblSeats.text = ticketVO.seat
            lblTotal.text = ticketVO.total
            
            
            ivQRCode.sd_setImage(with: URL(string: ticketVO.qrCode ?? ""))
            
            let posterImageUrl = MovieAppURL.moviePosterImage(path: movie.posterPath).asPosterImageURL()
            ivMoviePoster.sd_setImage(with: posterImageUrl)

        }
    }
    
    @objc func onTapBack(){
        navigateToMainScreen()
    }
   
    
}

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
}
