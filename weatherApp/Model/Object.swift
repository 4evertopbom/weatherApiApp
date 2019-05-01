//
//  Object.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/31/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation

class Object: Decodable {
    var latitude: Double?
    var longitude: Double?
    var timezone: String?
    var currently: Currently?
    var hourly: Hourly?
    var daily: Daily?
    var flags: Flags?
    var offset: Double?
    var minutely: Minutely?
}
