//
//  Data.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/31/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation

class Currently: Decodable {
    var time: Int?
    var summary: String?
    var icon: String?
    var precipIntensity: Double?
    var precipProbability: Double?
    var precipType: String?
    var temperature: Double?
    var apparentTemperature: Double?
    var dewPoint: Double?
    var humidity: Double?
    var pressure: Double?
    var windSpeed: Double?
    var windGust: Double?
    var windBearing: Double?
    var cloudCover: Double?
    var uvIndex: Int?
    var visibility: Double?
    var ozone: Double?
    var nearestStormDistance: Double?
    var nearestStormBearing: Double?
}
