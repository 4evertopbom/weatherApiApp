//
//  extensions.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/27/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, paddingtop: CGFloat, left: NSLayoutXAxisAnchor?, paddingleft: CGFloat, right: NSLayoutXAxisAnchor?, paddingright: CGFloat, bot: NSLayoutYAxisAnchor?, botpadding: CGFloat, height: CGFloat, width: CGFloat){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingtop).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingright).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingleft).isActive = true
        }
        
        if let bot = bot {
            self.bottomAnchor.constraint(equalTo: bot, constant: botpadding).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension Notification.Name {
    static let choseCity = Notification.Name(rawValue: "ChoseCity")
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds))
    }
}
