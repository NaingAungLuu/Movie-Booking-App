//
//  ScheduleDayTableViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 04/08/2021.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    

    @IBOutlet weak var collectionViewDays: UICollectionView!
    
    private var dateList : [Date]?
    
    private var selectedIndex : Int = 0
    
    var onSelectDate : ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCollectionViews()
        setupCalendarData()
    }
    
    private func setupCalendarData(){
        let today = Date()
        var endDate = Date()
        endDate.addDays(n: 30)
        
        dateList = today.getAllDatesUntil(endDate: endDate)
        collectionViewDays.reloadData()
        
        let selectedDate = dateList![selectedIndex].getFullDateInString()
        onSelectDate?(selectedDate)
    }
    
    
    private func setupCollectionViews() {
        collectionViewDays.delegate = self
        collectionViewDays.dataSource = self
        
        collectionViewDays.registerCell(identifier: DaysCollectionViewCell.identifier)
    }
    
}

extension CalendarTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ tableView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList?.count ?? 0
    }
    
    func collectionView(_ tableView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewDays.dequeueReusableCell(withReuseIdentifier: DaysCollectionViewCell.identifier, for: indexPath)
                as? DaysCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = dateList?[indexPath.row]
        if indexPath.row == selectedIndex {
            cell.isSelected = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) / 6.5 , height: CGFloat(70))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DaysCollectionViewCell {
            cell.currentState = .SELECTED
            cell.isSelected = true
            selectedIndex = indexPath.row
        }
        let selectedDate = dateList![selectedIndex].getFullDateInString()
        onSelectDate?(selectedDate)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DaysCollectionViewCell {
            cell.currentState = .UNSELECTED
            cell.isSelected = false
            selectedIndex = -1
        }
    }
    
    
}
