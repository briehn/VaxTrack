//
//  MakeAppointmentViewController.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class MakeAppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var database: Database = Database()
    var provider : Provider!
    var appointment: Appointment?
    var virusTypeSearched: String = ""
    
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
        
        name.text = provider.firstName + " " + provider.lastName
        addressLabel.text = provider.address
        contactPhoneLabel.text = provider.contactPhone
        contactEmailLabel.text = provider.contactEmail
        websiteLabel.text = provider.website


        // Fetch slots for today by default
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
        let (dates, err) = database.fetchOpenTimeSlotsFor(providerID: provider.uid, date: date)
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
        // Combine selected date(yyyy-MM-dd) and time(HH:mm) to (yyyy-MM-dd hh:mm:ss)
        var appointmentDate: Date = Date()
        
        if let dateOnlyToString = DateUtil.dateOnlyToString(date: datePicker.date, withFormat: "") {
            let dateOnly = dateOnlyToString
            
            if let selectedTime = tabbedTime {
                let timeOnly = selectedTime + ":00" // hh:mm:00
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let combDate = dateOnly + " " + timeOnly
                if let finalDate = DateUtil.dateFrom(dateString: combDate) {
                    appointmentDate = finalDate // store finalDate into Appointment info
                }
            }
        }
        

        appointment = Appointment.init(appointmentID: 0, virusType: virusTypeSearched, date: appointmentDate, patientID: ST_User.shared.userID, providerID: provider.uid)

        
        
        // Store input data(appointment) into DB
        if let appt = appointment {
            print("appointment=\(appt.virusType),\(appt.date),\(appt.patientID),\(appt.providerID)")
            print("result==")
            database.storeAppointment(appointment: appt)
//            print(database.storeAppointment(appointment: appt))
        }
        
        
    }
    
    // Test. Hard-coding.
    func loadAvailableTimesByDefault() -> [String] {
        var times = [String]()

        // split into hour block from officeHourStart to officeHourEnd
        if let hourSlot = provider?.officeHourStart {
            print(hourSlot)
            if let hourEnd = provider?.officeHourEnd {
                print(hourEnd)
                var nextSlot = hourSlot
                var hourBlock: [String]
                var slotInInt = 0
                while true {
                    times.append(nextSlot)
                    if nextSlot == hourEnd { // stop increment
                        break
                    } else {
                        hourBlock = nextSlot.components(separatedBy: ":") // [0] : hh , [1] : MM
                        slotInInt = Int(hourBlock[0])!// convert to int to increment by 1
                        slotInInt = slotInInt + 1 // increment by 1
                        nextSlot = "\(slotInInt):00" // hh:00
                    }
                }
            }
        }
        
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
                vc.selectedVirusType = virusTypeSearched
                vc.provider = provider
                vc.appointment = appointment
                vc.tabbedTime = tabbedTime!
                vc.selectedDate = selectedDate!
            }
        }
    }

}
