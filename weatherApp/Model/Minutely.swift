//
//  Minutely.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/31/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation

class Minutely: Decodable {
    var summary: String?
    var icon: String?
    var data: [DataMinutely]
}
