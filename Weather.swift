//
// Created by Justin Needham on 2019-03-05.
// Copyright (c) 2019 Treehouse. All rights reserved.
//

import Foundation

struct Weather {
    let currently: CurrentWeather
}

extension Weather {
    init?(json: [String: AnyObject]) {
        guard let currentWeatherJson = json["currently"] as? [String: AnyObject], let currentWeather = CurrentWeather(json: currentWeatherJson) else {
            return nil
        }

        self.currently = currentWeather
    }
}