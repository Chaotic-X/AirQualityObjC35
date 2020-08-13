//
//  AXLStatesListViewController.swift
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

import UIKit

class AXLStatesListViewController: UIViewController {

    
    var countrySelected: String?
    var states: [String] = [] {
        didSet {
            updateStatesTableView()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let countrySelected = countrySelected else { return }
        AXLCityAirQualityController.sharedInstance().fetchSupportedStates(inCountry: countrySelected) { (states) in
            if let states = states {
                self.states = states
            }
        }
    }
    
    
    func updateStatesTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Setting Custom Back Button Text
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back To States", style: .plain, target: nil, action: nil)
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let countrySelected = countrySelected,
                  let destinationVC = segue.destination as? AXLCitiesListViewController else { return }
            let selectedState = states[indexPath.row]
            destinationVC.country = countrySelected
            destinationVC.state = selectedState
        }
    }
}

extension AXLStatesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
}
