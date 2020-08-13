//
//  AXLCitiesListViewController.swift
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

import UIKit

class AXLCitiesListViewController: UIViewController {

    var state: String?
    var country: String?
    var cities: [String] = [] {
        didSet {
            updateCitiesTableView()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        guard let state = state,
              let country = country else { return }
        AXLCityAirQualityController.sharedInstance().fetchSupportedCities(inState: state, country: country) { (cities) in
            if let cities = cities {
                self.cities = cities
            }
        }
    }
    
    func updateCitiesTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Setting Custom Back Button Text
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back To Cities", style: .plain, target: nil, action: nil)
        if segue.identifier == "toCityDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let country = country,
                  let state = state,
                  let destinationVC = segue.destination as? AXLCityDetailViewController else { return }
            let selectedCity = cities[indexPath.row]
            destinationVC.city = selectedCity
            destinationVC.state = state
            destinationVC.country = country
                    
        }
    }
}

extension AXLCitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    
}
