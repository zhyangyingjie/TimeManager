//
//  TMTimeHandler.swift
//  TimeManager
//
//  Created by 张英杰 on 2018/11/24.
//  Copyright © 2018年 张英杰. All rights reserved.
//

import UIKit



class TMTimeHandler: NSObject {

    private static let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    func getCurrentYear() -> Int {
        let component = getComponent()
        return component.year!
    }
    
    func getWholeYearSecond(year: Int) -> TimeInterval {
        
        let yearStartString = "\(year)-01-01"
        let yearEndString = "\(year)-12-31"
        let yearStartDate = TMTimeHandler.dateformatter.date(from: yearStartString)
        let yearEndDate = TMTimeHandler.dateformatter.date(from: yearEndString)
        return yearEndDate!.timeIntervalSince(yearStartDate!)
    }
    
    func getPassedSecondThisYear(year: Int) -> TimeInterval {
        
        let yearStartString = "\(year)-01-01"
        let yearStartDate = TMTimeHandler.dateformatter.date(from: yearStartString)
        
        return Date().timeIntervalSince(yearStartDate!)
    }
    
    private func getComponent() -> DateComponents {
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: Date())
        return component
    }
    
    
}
