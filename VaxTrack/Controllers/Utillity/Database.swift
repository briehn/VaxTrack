//
//  Database.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import Foundation

class Database {
    static let instance: Database = Database()
    var uid:Int?
    
    init() {
    }
    static func getInstance() -> Database {
        return instance
    }

    // Fetch login result from Database. empty on failure
    func fetchLogin(login: String, password: String) -> (LoginModel?, MyError) {
        let param = [
            "login": JSONParser.toString(login),
            "password": JSONParser.toString(password)
        ]
        let (obj, err) = DatabaseConnection.fetchData("login", param)
        return (obj as? LoginModel, err)
    }

    // Fetch Patient Info for the passed patientID
    func fetchPatient(patientID: Int) -> (Patient?, MyError) {
        let param = [
            "uid": JSONParser.toString(patientID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("u_profile", param)
        //return (obj as? Patient, err)
        if (obj != nil) {
            let pat = obj as! Patient
            let (recs, err2) = fetchVaccinationRecordsForPatient(patientID: patientID)
            if (recs != nil) {
                var arr = [Int]()
                for rec in recs as! [Record] {
                    arr.append(rec.recordID)
                }
                pat.recordIDs = arr
            }
            let (apps, err3) = fetchAppointmentListForPatient(patientID: patientID)
            if (apps != nil) {
                var arr = [Int]()
                for app in apps as! [Appointment] {
                    arr.append(app.appointmentID)
                }
                pat.appointmentIDs = arr
            }
            let (ress, err4) = fetchTestResultsForPatient(patientID: patientID)
            if (ress != nil) {
                var arr = [Int]()
                for res in ress as! [TestResult] {
                    arr.append(res.resultID)
                }
                pat.resultIDs = arr
            }
            return (pat, err)
        } else {
            return (nil, err)
        }
    }

    // Fetch Patients Info with the passed virusType and appointmented with the provider
    func fetchPatientsWithAppointment(providerID: Int, virusType: String) -> ([Patient]?, MyError) {
        var err:MyError, obj:NSObject?
        let param = [
            "virustype": JSONParser.toString(virusType),
            "pid": JSONParser.toString(providerID),
        ]
        if virusType == "" {
            (obj, err) = DatabaseConnection.fetchData("u_list", nil)
        } else {
            (obj, err) = DatabaseConnection.fetchData("u_listfilterapp", param)
        }
        //return (obj as? Patient, err)
        if (obj != nil) {
            let pats = obj as! [Patient]
            for pat in pats {
                let (recs, err2) = fetchVaccinationRecordsForPatient(patientID: pat.uid)
                if (recs != nil) {
                    var arr = [Int]()
                    for rec in recs as! [Record] {
                        arr.append(rec.recordID)
                    }
                    pat.recordIDs = arr
                }
                let (apps, err3) = fetchAppointmentListForPatient(patientID: pat.uid)
                if (apps != nil) {
                    var arr = [Int]()
                    for app in apps as! [Appointment] {
                        arr.append(app.appointmentID)
                    }
                    pat.appointmentIDs = arr
                }
                let (ress, err4) = fetchTestResultsForPatient(patientID: pat.uid)
                if (ress != nil) {
                    var arr = [Int]()
                    for res in ress as! [TestResult] {
                        arr.append(res.resultID)
                    }
                    pat.resultIDs = arr
                }
            }
            return (pats, err)
        } else {
            return (nil, err)
        }
    }

    // Fetch Patients Info with the passed virusType and appointmented with the provider
    func fetchPatientsWithRecord(providerID: Int, virusType: String) -> ([Patient]?, MyError) {
        var err:MyError, obj:NSObject?
        let param = [
            "virustype": JSONParser.toString(virusType),
            "pid": JSONParser.toString(providerID),
        ]
        if virusType == "" {
            (obj, err) = DatabaseConnection.fetchData("u_list", nil)
        } else {
            (obj, err) = DatabaseConnection.fetchData("u_listfilterrec", param)
        }
        //return (obj as? Patient, err)
        if (obj != nil) {
            let pats = obj as! [Patient]
            for pat in pats {
                let (recs, err2) = fetchVaccinationRecordsForPatient(patientID: pat.uid)
                if (recs != nil) {
                    var arr = [Int]()
                    for rec in recs as! [Record] {
                        arr.append(rec.recordID)
                    }
                    pat.recordIDs = arr
                }
                let (apps, err3) = fetchAppointmentListForPatient(patientID: pat.uid)
                if (apps != nil) {
                    var arr = [Int]()
                    for app in apps as! [Appointment] {
                        arr.append(app.appointmentID)
                    }
                    pat.appointmentIDs = arr
                }
                let (ress, err4) = fetchTestResultsForPatient(patientID: pat.uid)
                if (ress != nil) {
                    var arr = [Int]()
                    for res in ress as! [TestResult] {
                        arr.append(res.resultID)
                    }
                    pat.resultIDs = arr
                }
            }
            return (pats, err)
        } else {
            return (nil, err)
        }
    }

    // Fetch Provider Info with the passed providerID
    func fetchProvider(providerID: Int) -> (Provider?, MyError) {
        let param = [
            "pid": JSONParser.toString(providerID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("p_profile", param)
        //return (obj as? Provider, err)
        if (obj != nil) {
            let pro = obj as! Provider
            pro.services = [String]()
            let (vacs, err2) = fetchVaccineListForProvider(providerID: providerID)
            if (vacs != nil) {
                var arr = [String]()
                for vac in vacs as! [Vaccine] {
                    arr.append(vac.virusType!)
                }
                pro.services += arr
            }
            let (tess, err3) = fetchTestListForProvider(providerID: providerID)
            if (tess != nil) {
                var arr = [String]()
                for tes in tess as! [Test] {
                    arr.append(tes.virusType!)
                }
                pro.services += arr
            }
            return (pro, err)
        } else {
            return (nil, err)
        }
    }

    // Fetch Providers Info with the passed virusType
    func fetchProvidersWhoOffer(virusType: String) -> ([Provider]?, MyError) {
        var err:MyError, obj:NSObject?
        let param = [
            "virustype": JSONParser.toString(virusType),
        ]
        if virusType == "" {
            (obj, err) = DatabaseConnection.fetchData("p_list", nil)
        } else {
            (obj, err) = DatabaseConnection.fetchData("p_listfilter", param)
        }
        //return (obj as? Provider, err)
        if (obj != nil) {
            let pros = obj as! [Provider]
            for pro in pros {
                pro.services = [String]()
                let (vacs, err2) = fetchVaccineListForProvider(providerID: pro.uid)
                if (vacs != nil) {
                    var arr = [String]()
                    for vac in vacs as! [Vaccine] {
                        arr.append(vac.virusType!)
                    }
                    pro.services += arr
                }
                let (tess, err3) = fetchTestListForProvider(providerID: pro.uid)
                if (tess != nil) {
                    var arr = [String]()
                    for tes in tess as! [Test] {
                        arr.append(tes.virusType!)
                    }
                    pro.services += arr
                }
            }
            return (pros, err)
        } else {
            return (nil, err)
        }
    }

    // Fetch admin profile
    func fetchAdminInfo(adminID: Int) -> (Admin?, MyError) {
        let param = [
            "aid": JSONParser.toString(adminID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("a_profile", param)
        return (obj as? Admin, err)
    }

    // Store patient information once signed up
    func regPatientInfo(withEmail email: String, password: String) -> MyError {
        var err:MyError, obj:NSObject?

        var param = [
            "login": JSONParser.toString(email),
            "password": JSONParser.toString(password),
            //"targetid": JSONParser.toString(uid)
        ]
        (_, err) = DatabaseConnection.fetchData("u_newlogin", param)
        if err.code != 0 {return err}

        param = ["login": email]
        (obj, err) = DatabaseConnection.fetchData("u_query", param)
        if err.code != 0 {return err}
        if obj == nil {return MyError(1)}
        let login = obj as! LoginModel
        let uid = login.uid
        
        let patient = Patient(uid: uid, firstName: email)
        param = patient.toDict()
        (_, err) = DatabaseConnection.fetchData("u_reg", param)
        return err
    }
    
    // Store patient information after edit profile
    func storePatientInfo(_ patient: Patient) -> MyError {
        let param = patient.toDict()
        let (_, err) = DatabaseConnection.fetchData("u_reg", param)
        return err
    }
    
    // Store provider information once signed up
    func regProviderInfo(withEmail email: String, password: String, org: String) -> MyError {
        var err:MyError, obj:NSObject?
        
        var param = [
            "login": JSONParser.toString(email),
            "password": JSONParser.toString(password),
            //"targetid": JSONParser.toString(uid)
        ]
        (_, err) = DatabaseConnection.fetchData("p_newlogin", param)
        if err.code != 0 {return err}
        
        param = ["login": email]
        (obj, err) = DatabaseConnection.fetchData("p_query", param)
        if err.code != 0 {return err}
        if obj == nil {return MyError(1)}
        let login = obj as! LoginModel
        let uid = login.uid
        
        let provider = Provider(uid: uid, firstName: email, organizationName: org)
        param = provider.toDict()
        (_, err) = DatabaseConnection.fetchData("p_reg", param)
        return err
    }
    
    // Store provider information after edit profile
    func storeProviderInfo(_ provider: Provider) -> MyError {
        let param = provider.toDict()
        let (_, err) = DatabaseConnection.fetchData("p_reg", param)
        return err
    }
    
    // Store coordinates(lat, lon) into Provider - it needs in order to calculate distance used in Find Provider
    func storeCoordinates(providerID: Int, lat: Float32, lng: Float32) -> MyError {
        let param = [
            "pid": JSONParser.toString(providerID),
            "lat": JSONParser.toString(lat),
            "lng": JSONParser.toString(lng)
        ]
        let (_, err) = DatabaseConnection.fetchData("p_storecoord", param)
        return err
    }
    
    // Store record made by Provider
    // argument might be Record or
    // all of the class(Record) members except recordID (which db will generate in AI)
    func storeRecord(record: Record) -> MyError {
        let param = record.toDict()
        let (_, err) = DatabaseConnection.fetchData("uv_done", param)
        return err
    }
    
    // Store appointment data made by Patient
    // argument might be Appointment or
    // all of the class(Appointment) members except appointmentID (which db will generate)
    func storeAppointment(appointment: Appointment) -> MyError {
        let param = appointment.toDict()
        let (_, err) = DatabaseConnection.fetchData("o_new", param)
        return err
    }
    
    // Fetch open time slots on the given date set by passed paroviderID from Database
    func fetchOpenTimeSlotsFor(providerID: Int, date: Date) -> ([Date]?, MyError) {
        ////////
        // it's extremely hard for database to do such things...
        // could I return a list of appointed times so that you could calculate it in the app?
        ////////
        return (nil, MyError())
    }
    
    // Fetch Vaccination Records for the current user
    func fetchVaccinationRecordsForCurrentUser() -> ([Record]?, MyError) {
        ////////
        // if current user is patient then call fetchVaccinationRecordsForPatient
        // else if current user is provider then call fetchVaccinationRecordsForProvider
        ////////
        return (nil, MyError())
    }
    
    // Fetch Vaccination Records for the passed patientID
    func fetchVaccinationRecordsForPatient(patientID: Int) -> ([Record]?, MyError) {
        let param = [
            "uid": JSONParser.toString(patientID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("uv_list", param)
        return (obj as? [Record], err)
    }
    
    // Fetch Vaccination Records for the passed providerID and all patients
    func fetchVaccinationRecordsForProvider(providerID: Int) -> ([Record]?, MyError) {
        let param = [
            "pid": JSONParser.toString(providerID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("puv_list", param)
        return (obj as? [Record], err)
    }
    
    func fetchVaccinationRecordsForProviderWithCovid19(providerID: Int) -> ([Record]?, MyError) {
        let (obj, err) = fetchVaccinationRecordsForProvider(providerID: providerID, virusType: "Covid-19")
        return (obj, err)
    }
    
    // Fetch Vaccination Records for the passed providerID and patients with virusType
    func fetchVaccinationRecordsForProvider(providerID: Int, virusType: String) -> ([Record]?, MyError) {
        let param = [
            "pid": JSONParser.toString(providerID),
            "virusType": JSONParser.toString(virusType),
        ]
        let (obj, err) = DatabaseConnection.fetchData("puv_listfilter", param)
        return (obj as? [Record], err)
    }
    
    // Fetch Vaccination Record with Details
    func fetchVaccinationRecordDetails(for recordID: Int) -> (Record?, MyError) {
        let param = [
            "uvid": JSONParser.toString(recordID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("uv_detail", param)
        return (obj as? Record, err)
    }
    
    // Fetch Providers who offer the passsed service(vaccine or test)
    func fetchNearbyProviderListOffer(service: String) -> ([Provider]?, MyError) {
        // TBD
        return (nil, MyError())
    }
    
    // Fetch all vaccines provided list
    func fetchVaccineList() -> ([Vaccine]?, MyError) {
        let param:[String:String] = [:]
        let (obj, err) = DatabaseConnection.fetchData("v_list", param)
        return (obj as? [Vaccine], err)
    }

    // Fetch all vaccines provided by a provider
    func fetchVaccineListForProvider(providerID: Int) -> ([Vaccine]?, MyError) {
        let param = [
            "pid": JSONParser.toString(providerID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("pv_list", param)
        return (obj as? [Vaccine], err)
    }

    // Fetch all tests provided list
    func fetchVaccineList() -> ([Test]?, MyError) {
        let param:[String:String] = [:]
        let (obj, err) = DatabaseConnection.fetchData("t_list", param)
        return (obj as? [Test], err)
    }

    // Fetch all tests provided by a provider
    func fetchTestListForProvider(providerID: Int) -> ([Test]?, MyError) {
        let param = [
            "pid": JSONParser.toString(providerID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("pt_list", param)
        return (obj as? [Test], err)
    }

    // Fetch appointment list set to the passed patientID
    func fetchAppointmentListForPatient(patientID: Int) -> ([Appointment]?, MyError) {
        let param = [
            "uid": JSONParser.toString(patientID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("uo_list", param)
        return (obj as? [Appointment], err)
    }
    
    // Fetch appointment list set to the passed providerID
    func fetchAppointmentListForProvider(providerID: Int) -> ([Appointment]?, MyError) {
        let param = [
            "pid": JSONParser.toString(providerID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("po_list", param)
        return (obj as? [Appointment], err)
    }
    
    // Cancel appointment. releases open time slot
    func cancelAppointment(appointmentID: Int) -> MyError {
        let param = [
            "oid": JSONParser.toString(appointmentID),
        ]
        let (_, err) = DatabaseConnection.fetchData("o_cancel", param)
        return err
    }
    
    // Delete appointment once it's done. do not release open time slot
    func doneAppointment(appointmentID: Int) -> MyError {
        let param = [
            "oid": JSONParser.toString(appointmentID),
        ]
        let (_, err) = DatabaseConnection.fetchData("o_done", param)
        return err
    }
    
    // Fetch Test Results for the passed patientID
    func fetchTestResultsForPatient(patientID: Int) -> ([TestResult]?, MyError) {
        let param = [
            "uid": JSONParser.toString(patientID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("ut_list", param)
        return (obj as? [TestResult], err)
    }
    
    // Fetch Test Results for the passed providerID (and all patients?)
    func fetchTestResultsForProvider(providerID: Int) -> ([TestResult]?, MyError) {
        let param = [
            "pid": JSONParser.toString(providerID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("put_list", param)
        return (obj as? [TestResult], err)
    }
    
    // Fetch Test Result with Details
    func fetchTestResultDetails(for resultID: Int) -> (TestResult?, MyError) {
        let param = [
            "utid": JSONParser.toString(resultID),
        ]
        let (obj, err) = DatabaseConnection.fetchData("ut_detail", param)
        return (obj as? TestResult, err)
    }
    

    
    
}
