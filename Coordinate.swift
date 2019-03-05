//
// Created by Justin Needham on 2019-03-05.
// Copyright (c) 2019 Treehouse. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    public var description: String {
        return "\(latitude),\(longitude)"
    }

    static var alcatrazIsland: Coordinate {
        return Coordinate(latitude: 38.8267, longitude: -122.4233)
    }
}