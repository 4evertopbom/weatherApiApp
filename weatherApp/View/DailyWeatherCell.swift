//
//  DailyWeatherCell.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 4/1/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class DailyWeatherCell: UICollectionViewCell {
    
    var dailyweather: DataDaily? {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            
            guard let unwrappedDailyWeather = dailyweather else { return }
            guard let unixTime = unwrappedDailyWeather.time else { return }
            let date = Date(milliseconds: unixTime)
            let dayInWeek = dateFormatter.string(from: date)
            
            guard let iconName = unwrappedDailyWeather.icon else { return }
            guard let tempMax = unwrappedDailyWeather.temperatureMax else { return }
            let tMax = Int((tempMax-32)/1.8)
            guard let tempMin = unwrappedDailyWeather.temperatureMin else { return }
            let tMin = Int((tempMin-32)/1.8)
            
            DispatchQueue.main.async {
                self.dayLabel.text = dayInWeek
                self.iconImage.image = UIImage(named: iconName)
                self.maxTempLabel.text = tMax.description
                self.minTempLabel.text = tMin.description
            }
            
        }
    }
    
    let dayLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .white
        lb.textAlignment = .left
        return lb
    }()
    
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let minTempLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .gray
        lb.textAlignment = .center
        return lb
    }()
    
    let maxTempLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    func setupTemparature() {
        let stackview = UIStackView(arrangedSubviews: [maxTempLabel, minTempLabel])
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        addSubview(stackview)
        stackview.anchor(top: topAnchor, paddingtop: 3, left: nil, paddingleft: 0, right: rightAnchor, paddingright: -4, bot: bottomAnchor, botpadding: -2, height: 0, width: 80)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTemparature()
        addSubview(dayLabel)
        addSubview(iconImage)
        dayLabel.anchor(top: topAnchor, paddingtop: 3, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: maxTempLabel.bottomAnchor, botpadding: 0, height: 0, width: 120)
        iconImage.anchor(top: topAnchor, paddingtop: 3, left: nil, paddingleft: 9, right: nil, paddingright: 0, bot: maxTempLabel.bottomAnchor, botpadding: 0, height: 0, width: 30)
        iconImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
