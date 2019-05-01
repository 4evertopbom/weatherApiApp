//
//  City.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/27/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class City: Decodable {
    var id: Int
    var name: String
    var country: String
    var coord: Coord
}
