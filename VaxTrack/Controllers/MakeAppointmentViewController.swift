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
    
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!

    var availableTimes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let provider = provider {
            providerNameLabel.text = provider.providerName
            addressLabel.text = provider.address
            contactPhoneLabel.text = provider.contactPhone
            contactEmailLabel.text = provider.contactEmail
            websiteLabel.text = provider.website
        }

        // Fetch slots for today by default
        fetchAvailableTimeSlotsFor(date: Date())

        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        
    }
    
    // Fetch available time slots from DB
    // loadXXX = load data to in-app objects or etc...
    // fetchXXX = fetch data from DB or External Data Source
    func fetchAvailableTimeSlotsFor(date: Date) {
        if let dates = database.fetchOpenTimeSlotsFor(date: date) {
            for date in dates {
                if let dateStr = DateUtil.dateToString(date: date, withFormat: "hh:MM") {
                    availableTimes.append(dateStr)
                }
            }
        }
        timeTableView.reloadData()
    }

//    func loadAvailableTimesByDefault() -> [String] {
//        var times = [String]()
//        times.append("10:00")
//        times.append("11:00")
//        times.append("13:00")
//        times.append("16:00")
//        return times
//    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let time = availableTimes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentAvailableTimeCell", for: indexPath) as! AppointmentAvailableTimeCell
//        cell.availableTime.text = "10:00"
        cell.setTime(time: time)
        return cell
    }

}
