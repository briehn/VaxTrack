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
    
    // Store coordinates(lat, lon) into Provider - it needs in order to calculate distance used in Find Provider
    func storeCoordinates(providerID: Int) {
        
    }
    
    // Store patient information once signed up
    func storePatientInfo() {
        
    }
    
    // Store provider information once signed up
    func storeProviderInfo() {
        
    }
    
    // Store record made by Provider
    // argument might be Record or
    // all of the class(Record) members except recordID (which db will generate in AI)
    func storeRecord(record: Record ) {
        
    }
    
    // Store appointment data made by Patient
    // argument might be Appointment or
    // all of the class(Appointment) members except appointmentID (which db will generate)
    func storeAppointment(appointment: Appointment) {
        
    }
    
    // Fetch open time slots on the given date set by passed paroviderIDfrom Database
    func fetchOpenTimeSlotsFor(providerID: Int, date: Date) -> [Date]? {
        return nil
    }
    
    // Fetch Vaccination Records for the current user
    func fetchVaccinationRecordsForCurrentUser() -> [Record]? {
        return nil
    }
    
    // Fetch Vaccination Records for the passed providerID
    func fetchVaccinationRecordsForProvider(providerID: Int) -> [Record]? {
        return nil
    }
    
    // Fetch Vaccination Record with Details
    func fetchVaccinationRecordDetails(for recordID: Int) -> Record? {
        return nil
    }
    
    // Fetch Patient Info for the passed patientID
    func fetchPatient(patientID: Int) -> Patient? {
        return nil
    }
    
    // Fetch Provider Info with the passed providerID
    func fetchProvider(providerID: Int) -> Provider? {
        return nil
    }
    
    // Fetch Providers who offer the passsed service(vaccine or test)
    func fetchNearbyProviderListOffer(service: String) -> [Provider]?{
        return nil
    }
    
    // Fetch aapointment list set to the passed patientID
    func fetchAppointmentListForPatient(patientID: Int) -> [Appointment]? {
        return nil
    }
    
    // Fetch aapointment list set to the passed providerID
    func fetchAppointmentListForProvider(providerID: Int) -> [Appointment]? {
        return nil
    }
    
    
    
    
}
