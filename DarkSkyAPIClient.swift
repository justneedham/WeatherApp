//
// Created by Justin Needham on 2019-03-05.
// Copyright (c) 2019 Treehouse. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    fileprivate let darkSkyApiKey = "3ed18b7c5dc64c7e42c34708619c3835"

    lazy var baseUrl: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(darkSkyApiKey)/")!
    }()

    let downloader = JSONDownloader()

    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?) -> Void
    typealias WeatherCompletionHandler = (Weather?, DarkSkyError?) -> Void

    private func getWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }

                guard let weather = Weather(json: json) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }

                completion(weather, nil)
            }
        }

        task.resume()
    }

    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        getWeather(at: coordinate, completionHandler: { weather, error in
            completion(weather?.currently, error)
        })
    }
}