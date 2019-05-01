//
//  ChoseCityHeader.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/28/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class HourWeatherCell: UICollectionViewCell {
    
    var hourweather: DataHourly? {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
       //     let hourString = formatter.string(from: date)
            guard let unwrappedHourweather = hourweather else { return }
            guard let temp = unwrappedHourweather.temperature else { return }
            let t = Int((temp-32)/1.8)
            guard let iconName = unwrappedHourweather.icon else { return }
            guard let unixtime = unwrappedHourweather.time else { return }
            let date = Date(milliseconds: unixtime)
            let hour = formatter.string(from: date)
            DispatchQueue.main.async {
                self.tempLabel.text = "\(t.description)°"
                self.weatherImage.image = UIImage(named: iconName)
                if hour == formatter.string(from: Date()) {
                    self.hourLabel.text = "Now"
                    self.hourLabel.font = UIFont.boldSystemFont(ofSize: 17)
                }
                else {
                    if hour == "12 AM" {
                        self.hourLabel.text = "00 AM"
                        self.hourLabel.font = UIFont.systemFont(ofSize: 16)
                    }
                    else {
                        self.hourLabel.text = hour.description
                        self.hourLabel.font = UIFont.systemFont(ofSize: 16)
                    }
                }
            }
        }
    }
    
    let hourLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.text = "15"
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "clear-day")
        return iv
    }()
    
    let tempLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        addSubview(hourLabel)
        addSubview(weatherImage)
        addSubview(tempLabel)
        
        hourLabel.anchor(top: topAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 20, width: 0)
        weatherImage.anchor(top: hourLabel.bottomAnchor, paddingtop: 10, left: leftAnchor, paddingleft: 25, right: rightAnchor, paddingright: -25, bot: nil, botpadding: 0, height: 30, width: 0)
        tempLabel.anchor(top: weatherImage.bottomAnchor, paddingtop: 15, left: leftAnchor, paddingleft: 0 , right: rightAnchor, paddingright: 0, bot: bottomAnchor, botpadding: -5, height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
