//
//  MovieTimeGridTableViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/08/2021.
//

import UIKit

class MovieTimeGridTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewMovieTime: UICollectionView!
    @IBOutlet weak var lblCinemaName: UILabel!
    
    @IBOutlet weak var constraintCollectionView: NSLayoutConstraint!
    
    var title : String? {
        didSet {
            updateTitle()
        }
    }
    
    var data : MovieScheduleResult? {
        didSet {
            if data != nil {
                self.title = data?.cinema
                collectionViewMovieTime.indexPathsForSelectedItems?
                    .forEach { self.collectionViewMovieTime.deselectItem(at: $0, animated: false) }
                collectionViewMovieTime.reloadData()
                updateHeight()
            }
        }
    }
    
    var isCinemaSelected : Bool = false {
        didSet {
            if isCinemaSelected {
                collectionViewMovieTime.reloadData()
            } else {
                collectionViewMovieTime.allowsSelection = false
                collectionViewMovieTime.allowsSelection = true
                collectionViewMovieTime.indexPathsForSelectedItems?
                    .forEach { self.collectionViewMovieTime.deselectItem(at: $0, animated: false) }
                selectedTimeSlotIndex = -1
                collectionViewMovieTime.reloadData()
            }
            collectionViewMovieTime.allowsMultipleSelection = false
        }
    }
    
    var isForMovieFormats : Bool?
    
    var selectedTimeSlotIndex : Int = -1
    
    private var movieFormats : [String] = [ "2D" , "3D" , "IMAX"]
    
    var onHeightUpdated : (() -> Void)?
    
    var onSelectTimeSlot : ((MovieScheduleResult , Timeslot) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateHeight()
        setupCollectionView()

    }
    
    private func updateTitle() {
        if let title = title {
            lblCinemaName.text = title
        }
    }
    
    private func updateHeight() {
        let rowCount = roundf(Float(max(collectionViewMovieTime.numberOfItems(inSection: 0) / 3, 1)))
        
        constraintCollectionView.constant = CGFloat((((rowCount * 46)) + ((rowCount) * 10)))
        collectionViewMovieTime.layoutIfNeeded()
        onHeightUpdated?()
    }
    
    private func setupCollectionView() {
        collectionViewMovieTime.registerCell(identifier: MovieTimeCollectionViewCell.identifier)
        collectionViewMovieTime.delegate = self
        collectionViewMovieTime.dataSource = self
        collectionViewMovieTime.allowsSelection = true
        collectionViewMovieTime.allowsMultipleSelection = false
    }
    
}

extension MovieTimeGridTableViewCell : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isForMovieFormats ?? false {
            return movieFormats.count
        }else {
            return data?.timeslots?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTimeCollectionViewCell.identifier, for: indexPath)
                as? MovieTimeCollectionViewCell else {
            return UICollectionViewCell()
        }
        if isForMovieFormats ?? false { // Movie Formats
            cell.data = movieFormats[indexPath.row]
        } else { //Schedule
            cell.data = data?.timeslots?[indexPath.row].startTime
        }
        if indexPath.row == selectedTimeSlotIndex {
            cell.currentState = .SELECTED
        }else {
            cell.currentState = .UNSELECTED
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 48) * 0.3;
        print("Collectionview with \(collectionView.bounds.width)")
        let height = CGFloat(46)
        return CGSize(width:  width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieTimeCollectionViewCell else {
            return
        }
//        cell.currentState = .SELECTED
        selectedTimeSlotIndex = indexPath.row
        collectionViewMovieTime.reloadData()
        self.onSelectTimeSlot?(data! , data!.timeslots![indexPath.row])
    }
    
}
