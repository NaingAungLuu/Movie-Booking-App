//
//  ExtensionUtils.swift
//  Movie Booking App
//
//  Created by Harry Jason on 04/06/2021.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier : String {
        return String(describing: self)
    }
    var identifier : String {
        return String(describing: self)
    }
    
    var networkAgent : NetworkAgentModel {
        return AlamofireNetworkAgentImpl.shared
    }
    
}
extension UIView {
    static var identifier : String {
        get {
            return String(describing: self)
        }
    }
}

extension UICollectionView {
    func registerCell(identifier : String){
        self.register(
            UINib(
                nibName: identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: identifier
        )
    }
}

extension UITableView {
    func registerCell(identifier : String){
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
}

extension UITextField {
  func useUnderline() -> Void {
    let border = CALayer()
    let borderWidth = CGFloat(0.5) // Border Width
    border.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}

func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = UIColor.lightGray.cgColor
    shapeLayer.lineWidth = 1
    shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

    let path = CGMutablePath()
    path.addLines(between: [p0, p1])
    shapeLayer.path = path
    view.layer.addSublayer(shapeLayer)
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension Date {
    
    func getAllDatesUntil(endDate : Date) -> [Date] {
        var dateList : [Date] = []
        
        let range = Calendar.current.range(of: .day, in: .month, for: endDate)
        
        var currentDay = Date()
        dateList.append(currentDay)
        
        range?.forEach({ _ in
            currentDay.addDays(n: 1)
            dateList.append(currentDay)
        })
        
        return dateList
    }
    
    func getDayInString() -> String {
//        let date = Calendar.current.dateComponents(Set([Calendar.Component.day]), from: self).weekdayOrdinal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let dayInWeek = dateFormatter.string(from: self)
        return dayInWeek
    }
    
    func getDateInString() -> String {
        let dayComponent = Calendar.current.dateComponents(Set([Calendar.Component.day]), from: self)
        return String(dayComponent.day ?? 0)
    }
    
    func getFullDateInString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dayInWeek = dateFormatter.string(from: self)
        return dayInWeek
    }
    
    mutating func addDays(n: Int)
    {
            let cal = Calendar.current
            self = cal.date(byAdding: .day, value: n, to: self)!
    }
}


class ThemeColor {    
    static let ACCENT = UIColor(named: "color_accent")
    static let GREEN = UIColor(named: "color_green")
    static let SEAT_TAKEN = UIColor(named: "color_seat_taken")
    static let SEAT_AVAILABLE = UIColor(named: "color_seat_available")
}
