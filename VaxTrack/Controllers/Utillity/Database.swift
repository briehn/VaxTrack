//
//  Database.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import Foundation

class Database {
    init() {
        
    }

    // Fetch open time slots on the given date from Database
    func fetchOpenTimeSlotsFor(date: Date) -> [Date]? {
        return nil
    }
    
    // Fetch Vaccination Records for the current user
    func fetchVaccinationRecords() -> [Record]? {
        return nil
    }
    
    // Fetch Vaccination Record with Details
    func fetchVaccinationRecordDetails(for recordID: Int) -> Record? {
        return nil
    }
}
