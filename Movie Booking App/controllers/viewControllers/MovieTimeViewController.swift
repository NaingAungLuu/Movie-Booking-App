//
//  MovieTimeViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 30/05/2021.
//

import Foundation
import UIKit
class MovieTimeViewController : BaseViewController {
    
    //View Outlets
    @IBOutlet weak var movieTimeContainer: UIView!
    @IBOutlet weak var tableViewBody: UITableView!
    
    @IBAction func onTapGetTicket(_ sender: Any) {
        if selectedCinema != nil && selectedTimeSlot != nil && selectedDate != nil{
            UserPreference.selectedCinema = selectedCinema
            UserPreference.selectedTime = selectedTimeSlot
            UserPreference.selectedDate = selectedDate
            navigateToSeatPlanScreen(cinema: selectedCinema!, timeSlot: selectedTimeSlot!, date : selectedDate!)
        } else {
            self.showErrorDialog(message: "Please select time")
        }
    }
    @IBAction func onTapBack(_ sender: Any) {
        navigateBack()
    }
    
    private var cinemaList : [MovieScheduleResult]?
    
    private var selectedDate : String?
    private var selectedCinema : MovieScheduleResult?
    private var selectedTimeSlot : Timeslot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerCells()
        setupTableView()
        setupCollectionViewHeights()
        setupScrollView()
    }
    
    private func setupScrollView() {
        movieTimeContainer.layer.cornerRadius = 15
        movieTimeContainer.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner]
    }
    
    func setupCollectionViewHeights(){
        
    }
    
    private func registerCells(){
        tableViewBody.registerCell(identifier: CalendarTableViewCell.identifier)
        tableViewBody.registerCell(identifier: MovieTimeGridTableViewCell.identifier)
    }
    
    private func setupTableView(){
        tableViewBody.dataSource = self
        tableViewBody.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func fetchCinemaData(date : String) {
        self.showLoadingDialog()
        networkAgent.getMovieSchedule(date: date) { result in
            switch result {
            case .success(let response) :
                self.dismissDialog()
                if let cinemaList = response.data {
                    self.cinemaList = cinemaList
                    self.selectedCinema = cinemaList.first
                    self.tableViewBody.reloadData()
                }
            case .failure(let errorMessage):
                self.dismissDialog()
                self.showErrorDialog(message: errorMessage)
            }
        }
    }
}

extension MovieTimeViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 + (cinemaList?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.identifier) as? CalendarTableViewCell else {
                return UITableViewCell()
            }
            cell.onSelectDate = { date in
                self.selectedDate = date
                self.fetchCinemaData(date: date)
            }
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTimeGridTableViewCell.identifier) as? MovieTimeGridTableViewCell else {
                return UITableViewCell()
            }
            cell.onHeightUpdated = {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            if indexPath.section == 1 { // Movie Formats
                cell.title = "Available Formats"
                cell.isForMovieFormats = true
            }
            else { //Cinema
                cell.isForMovieFormats = false
                cell.data = cinemaList?[indexPath.section - 2]
                if cell.data?.cinemaID == selectedCinema?.cinemaID {
                    cell.isCinemaSelected = true
                } else {
                    cell.isCinemaSelected = false
                }
                cell.onSelectTimeSlot = { cinema , timeslot in
                    self.selectedCinema = cinema
                    self.selectedTimeSlot = timeslot
                    self.tableViewBody.reloadData()
                }
            }
            return cell
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(tableViewBody.contentOffset.y)
        if tableViewBody.contentOffset.y < 0 {
            tableViewBody.backgroundColor = ThemeColor.ACCENT
            
        } else {
            tableViewBody.backgroundColor = .white
        }
    }
    
    
}
