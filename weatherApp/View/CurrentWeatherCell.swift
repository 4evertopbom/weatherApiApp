//
//  CurrentWeatherCell.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 4/1/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class CurrentWeatherCell: UICollectionViewCell {
    
    var currentweather: Currently? {
        didSet {
            guard let unwrappedCurrentWeather = currentweather else { return }
            guard let rainProbility = unwrappedCurrentWeather.precipProbability else { return }
            guard let humidity = unwrappedCurrentWeather.humidity else { return }
            guard let windSpeed = unwrappedCurrentWeather.windSpeed else { return }
            guard let visibility = unwrappedCurrentWeather.visibility else { return }
            DispatchQueue.main.async {
                self.setRainLabel.text = "\((Int(rainProbility * 100)).description)%"
                self.setHumidityLabel.text = "\((Int(humidity * 100)).description)%"
                self.setwindSpeedLabel.text = "\((Int(windSpeed * 1.609)).description)km/h"
                self.setPressureLabel.text = "\(unwrappedCurrentWeather.pressure!.description)mb"
                self.setVisibilityeLabel.text = "\((Int(visibility * 1.609)).description)km"
                self.setuvIndexLabel.text = unwrappedCurrentWeather.uvIndex?.description
            }
            
        }
    }
    
    var dailyweather: DataDaily? {
        didSet {
            guard let sunriseDate = dailyweather?.sunriseTime else { return }
            guard let sunsetDate = dailyweather?.sunsetTime else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let sunriseTime = Date(milliseconds: sunriseDate)
            let sunsetTime = Date(milliseconds: sunsetDate)
            DispatchQueue.main.async {
                self.setSunriseLabel.text = formatter.string(from: sunriseTime)
                self.setSunsetLabel.text = formatter.string(from: sunsetTime)
            }
        }
    }
    
    let sunriseLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "Sunrise"
        return lb
    }()
    
    let setSunriseLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let sunsetLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "Sunset"
        return lb
    }()
    
    let setSunsetLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let rainAbilityLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "Rain Probility"
        return lb
    }()
    
    let setRainLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let humidityLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "Humidity"
        return lb
    }()
    
    let setHumidityLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let windSpeedLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "Wind speed"
        return lb
    }()
    
    let setwindSpeedLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let pressureLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "Pressure"
        return lb
    }()
    
    let setPressureLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let visibilityLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "Visibility"
        return lb
    }()
    
    let setVisibilityeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let uvIndexLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = UIColor.lightGray
        lb.text = "UV index"
        return lb
    }()
    
    let setuvIndexLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "-"
        return lb
    }()
    
    let separateLine1:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let separateLine2:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let separateLine3:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sunriseLabel)
        addSubview(sunsetLabel)
        addSubview(setSunsetLabel)
        addSubview(setSunriseLabel)
        addSubview(rainAbilityLabel)
        addSubview(setRainLabel)
        addSubview(humidityLabel)
        addSubview(setHumidityLabel)
        addSubview(windSpeedLabel)
        addSubview(setwindSpeedLabel)
        addSubview(pressureLabel)
        addSubview(setPressureLabel)
        addSubview(visibilityLabel)
        addSubview(setVisibilityeLabel)
        addSubview(uvIndexLabel)
        addSubview(setuvIndexLabel)
        addSubview(separateLine1)
        addSubview(separateLine2)
        addSubview(separateLine3)
        
        sunriseLabel.anchor(top: topAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: frame.width/2 - 16)
        sunsetLabel.anchor(top: topAnchor, paddingtop: 5, left: sunriseLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: 0)
        setSunriseLabel.anchor(top: sunriseLabel.bottomAnchor, paddingtop: 3, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: frame.width/2 - 16)
        setSunsetLabel.anchor(top: setSunriseLabel.topAnchor, paddingtop: 0, left: setSunriseLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: 0)
        separateLine1.anchor(top: setSunriseLabel.bottomAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 16, right: rightAnchor, paddingright: -16, bot: nil, botpadding: 0, height: 0.5, width: 0)
        rainAbilityLabel.anchor(top: separateLine1.bottomAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: frame.width/2 - 16)
        humidityLabel.anchor(top: rainAbilityLabel.topAnchor, paddingtop: 0, left: rainAbilityLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: 0)
        setRainLabel.anchor(top: rainAbilityLabel.bottomAnchor, paddingtop: 3, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: frame.width/2 - 16)
        setHumidityLabel.anchor(top: setRainLabel.topAnchor, paddingtop: 0, left: setRainLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: 0)
        separateLine2.anchor(top: setRainLabel.bottomAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 16, right: rightAnchor, paddingright: -16, bot: nil, botpadding: 0, height: 0.5, width: 0)
        windSpeedLabel.anchor(top: separateLine2.bottomAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: frame.width/2 - 16)
        pressureLabel.anchor(top: windSpeedLabel.topAnchor, paddingtop: 0, left: windSpeedLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: 0)
        setwindSpeedLabel.anchor(top: windSpeedLabel.bottomAnchor, paddingtop: 3, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: frame.width/2 - 16)
        setPressureLabel.anchor(top: setwindSpeedLabel.topAnchor, paddingtop: 0, left: setwindSpeedLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: 0)
        separateLine3.anchor(top: setwindSpeedLabel.bottomAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 16, right: rightAnchor, paddingright: -16, bot: nil, botpadding: 0, height: 0.5, width: 0)
        visibilityLabel.anchor(top: separateLine3.bottomAnchor, paddingtop: 5, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: frame.width/2 - 16)
        uvIndexLabel.anchor(top: visibilityLabel.topAnchor, paddingtop: 0, left: visibilityLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 17, width: 0)
        setVisibilityeLabel.anchor(top: visibilityLabel.bottomAnchor, paddingtop: 3, left: leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: frame.width/2 - 16)
        setuvIndexLabel.anchor(top: setVisibilityeLabel.topAnchor, paddingtop: 0, left: setVisibilityeLabel.rightAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 24, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
