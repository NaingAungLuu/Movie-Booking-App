//
//  MovieCarousel.swift
//  Movie Booking App
//
//  Created by Harry Jason on 05/06/2021.
//

import Foundation
import UIKit
@IBDesignable class MovieCarousel : UIView {
    
    @IBInspectable
    var header : String = "" {
        didSet {
            labelHeader.text = header
        }
    }
    
    var movieList : [MovieListItem]? {
        didSet {
            collectionViewMovies.reloadData()
        }
    }
    var view: UIView!
    
    var onTapMovie : ((Int) -> Void)?
    
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        loadViewFromNib()
    }
    override init(frame: CGRect) {
       super.init(frame: frame)
        loadViewFromNib()
    }
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
        initView()
    }
    private func initView(){
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        collectionViewMovies.registerCell(identifier: MovieCarouselCollectionViewCell.identifier)
    }
}

extension MovieCarousel : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCarouselCollectionViewCell.identifier, for: indexPath)
                as? MovieCarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.movie = movieList?[indexPath.row]
        cell.index = indexPath.row
        cell.onTapMovie = self.onTapMovie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.frame.width * 0.5) , height: CGFloat(collectionView.frame.height))
    }
    
}
