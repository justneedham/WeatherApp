//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 5/8/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    fileprivate let darkSkyApiKey = "3ed18b7c5dc64c7e42c34708619c3835"
    let forecastUrl = URL(string: "https://api.darksky.net/forecast/3ed18b7c5dc64c7e42c34708619c3835/37.8267,-122.4233")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let base = URL(string: "https://api.darksky.net/forecast/\(darkSkyApiKey)/")
        guard let forecastUrl = URL(string: "37.8267,-122.4233", relativeTo: base) else {
            return
        }

        let request = URLRequest(url: forecastUrl)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            print(data)
        }

        dataTask.resume()


        let currentWeather = CurrentWeather(
                temperature: 85.0,
                humidity: 0.8,
                precipProbability: 0.1,
                summary: "Hot!",
                icon: "clear-day"
        )
        let viewModel = CurrentWeatherViewModel(model: currentWeather)
        displayWeather(using: viewModel)
    }

    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbability
        currentSummaryLabel.text = viewModel.summary
        currentWeatherIcon.image = viewModel.icon
    }
}

