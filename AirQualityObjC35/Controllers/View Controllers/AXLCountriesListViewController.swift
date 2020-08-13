//
//  AXLCountriesListViewController.swift
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

import UIKit

class AXLCountriesListViewController: UIViewController {
    
    //MARK: -Properties
    var countries: [String] = [] {
        didSet {
            updateCountriesTableView()
        }
    }
    
    //MARK: -Outlets
    //tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        AXLCityAirQualityController.sharedInstance().fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
            }
        }
    }
    
    func updateCountriesTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Setting Custom Back Button Text
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back to countries", style: .plain, target: nil, action: nil)
            if segue.identifier == "toStatesVC" {
                guard let indexPath = tableView.indexPathForSelectedRow,
                      let destinationVC = segue.destination as? AXLStatesListViewController else { return }
                
                let selectedCountry = countries[indexPath.row]
                destinationVC.countrySelected = selectedCountry
        }
    }
}

extension AXLCountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country
        return cell
    }
}
