//
//  AppointmentsViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//

import UIKit

class AppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var database: Database = Database()
    var appointments: [Appointment] = []
    
    var touchedCellBtnTag: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        appointments = createArray()
        
    }
    
    func createArray() -> [Appointment] {
        var tempAppointmemnts: [Appointment] = []
        
        let appointment = Appointment(appointmentID: 0001, virusType: "Covid-19", date: "2021-05-01", providerName: "Dr. Atrey", organizationName: "UAlbany", address: "1400 Washington Ave, NY 12222", contactPhone: "1(646)-777-7777", contactEmail: "email@email.com", website: "www.website.com")
        
        tempAppointmemnts.append(appointment)
        
        return tempAppointmemnts
    }
    
    // Cancel appointment
    @IBAction func cancelBtnTouched(_ sender: UIButton) {
        touchedCellBtnTag = sender.tag
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = appointments[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as! appointmentCell
        cell.setAppointment(appointment: appointment)
        cell.cancelBtn.tag = indexPath.row
        
        return cell
    }
    



}
