//
//  MakeAppointmentViewController.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class MakeAppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var database: Database = Database()
    var provider : Provider?
    var appointment: Appointment?
    
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!

    var availableTimes: [String] = []
    
    var tabbedTime: String?
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let provider = provider {
            name.text = provider.firstName + " " + provider.lastName
            addressLabel.text = provider.address
            contactPhoneLabel.text = provider.contactPhone
            contactEmailLabel.text = provider.contactEmail
            websiteLabel.text = provider.website
        }

        // Fetch slots for today by default
//        fetchAvailableTimeSlotsFor(date: Date())
        
        availableTimes = loadAvailableTimesByDefault()

        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        datePicker.datePickerMode = .date
        

    }
    
    @IBAction func datePickerTouched(_ sender: Any) {
        selectedDate = datePicker.date
    }
    
    // Fetch available time slots from DB
    // loadXXX = load data to in-app objects or etc...
    // fetchXXX = fetch data from DB or External Data Source
    func fetchAvailableTimeSlotsFor(date: Date) {
        let (dates, err) = database.fetchOpenTimeSlotsFor(providerID: (provider?.uid)!, date: date)
        if dates != nil {
            for date in dates! {
                if let dateStr = DateUtil.dateToString(date: date, withFormat: "hh:MM") {
                    availableTimes.append(dateStr)
                }
            }
        }
        timeTableView.reloadData()
    }
    
    @IBAction func makeAppointmentBtnTouched(_ sender: UIButton) {
        // Store input data into DB(appointment)
        print("makeAppointmentBtnTouched")
        // Store appointment data into DB
        appointment?.date = datePicker.date
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let strTest = formatter.string(from: (appointment?.date)!) // WHY RUNTIME ERROR- NIL???
//        print("aaaaaaaaaaaaa\n\n\n\n\n")
//        print(strTest)
        
        appointment?.providerID = provider?.uid
//        appointment?.patientID = 001
//        appointment?.appointmentID = 1
    }
    
    // Test. Hard-coding.
    func loadAvailableTimesByDefault() -> [String] {
        var times = [String]()
        times.append("10:00")
        times.append("11:00")
        times.append("13:00")
        times.append("16:00")
        return times
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 0, green: 117, blue: 102, alpha: 1)
        tabbedTime = availableTimes[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let time = availableTimes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentAvailableTimeCell", for: indexPath) as! AppointmentAvailableTimeCell
        
        cell.setTime(time: time)

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Preparing transition to Vaccine Detail Page
        if segue.identifier == "appointmentConfirmationSegue" {
            if let vc = segue.destination as? AppointmentConfirmationViewController {
                vc.provider = provider
                vc.appointment = appointment
                vc.tabbedTime = tabbedTime!
                vc.selectedDate = selectedDate!
            }
        }
    }

}
