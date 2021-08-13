//
//  MovieTagCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 05/06/2021.
//

import UIKit

class MovieTagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    var tagName : String = "" {
        didSet{
            updateTag()
        }
    }
    
    private func updateTag(){
        lblTag.text = tagName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainer.layer.cornerRadius = 17
    }
}
