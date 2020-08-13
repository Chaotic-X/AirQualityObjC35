//
//  AXLCityDetailViewController.swift
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

import UIKit

class AXLCityDetailViewController: UIViewController {
    
    // MARK: - Properties
    var country: String?
    var state: String?
    var city: String?
    
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
              let state = state,
              let country = country else { return }
        AXLCityAirQualityController.sharedInstance().fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            if let details = cityDetails {
                self.updateViews(with: details)
            }
        }
    }
    
    // MARK: - Class Methods
    func updateViews(with details: AXLCityAirQuality) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = "City: " + details.city
            self.stateLabel.text = "State: " + details.state
            self.countryLabel.text = "Country: " + details.country
            self.aqiLabel.text = "Air Quality Index: \(details.pollution.airQualityIndex)"
            self.windSpeedLabel.text = "Wind Spead: \(details.weather.windSpeed)"
            self.temperatureLabel.text = "Temperature: \(details.weather.temperature) ºC"
            self.humidityLabel.text = "Humidity: \(details.weather.humidity)%"
            self.navigationItem.title = details.city + ", " + details.state
        }
    }
} //End of class


