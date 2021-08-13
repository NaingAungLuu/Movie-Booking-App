//
//  CinemaTimeCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 30/07/2021.
//

import UIKit

class CinemaTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var collectionViewMovieTime: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
        lblCinemaName.text = "Cinema 1 : Junction"
    }
    
    private func setupCollectionView() {
        collectionViewMovieTime.registerCell(identifier: MovieTimeCollectionViewCell.identifier)
        collectionViewMovieTime.delegate = self
        collectionViewMovieTime.dataSource = self
        
    }

}

extension CinemaTimeTableViewCell : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTimeCollectionViewCell.identifier, for: indexPath)
                as? MovieTimeCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.3;
        print("Collectionview with \(collectionView.bounds.width)")
        let height = CGFloat(46)
        return CGSize(width:  width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieTimeCollectionViewCell else {
            return
        }
        cell.currentState = .SELECTED
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieTimeCollectionViewCell else {
            return
        }
        cell.currentState = .UNSELECTED
    }
    
}
