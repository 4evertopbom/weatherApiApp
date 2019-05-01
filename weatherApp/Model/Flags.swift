//
//  Flags.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/31/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation

class Flags: Decodable {
    var sources: [String]?
    var nearest_station: Double?
    var units: String?
}
