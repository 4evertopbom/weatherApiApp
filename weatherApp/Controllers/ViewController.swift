//
//  ViewController.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/25/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import UIKit
import DarkSkyKit

class ViewController: UIViewController {
    let cellHourID = "cellID"
    let cellForecastID = "cellForeCastID"
    let cellSummaryID = "cellsummaryID"
    let currentWeatherID = "currentWeatherID"
    
    var hourWeather = [DataHourly]()
    var dailyWeather = [DataDaily]()
    var currentlyWeather: Currently?
    
    
    let cityNameLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 40)
        lb.textColor = UIColor.white
        return lb
    }()
    
    let descripWeatherLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .white
        lb.text = "--"
        return lb
    }()
    
    let tempLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.text = "--"
        lb.font = UIFont.systemFont(ofSize: 130)
        lb.textColor = .white
        return lb
    }()
    
    let cenciusLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 70)
        lb.textColor = .white
        lb.text = "°"
        return lb
    }()
    
    let accessoryView: UIView = {
        let view = UIView()
        return view
    }()
    
    let choseCityButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "add"), for: .normal )
        bt.addTarget(self, action: #selector(handleChoseCity), for: .touchUpInside)
        return bt
    }()
    
    @objc func handleChoseCity() {
        let vc = UINavigationController(rootViewController: SearchCityController(collectionViewLayout: UICollectionViewFlowLayout()))
        //let vc = SearchVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    let separateView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let separateViewBot1: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let separateViewBot2: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let dayHourWeatherController: UICollectionView = {
        let clv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        return clv
    }()
    
    let dayDailyWeatherController: UICollectionView = {
        let clv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
        return clv
    }()
    
    let todayLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .white
        lb.backgroundColor = .clear
        return lb
    }()
    
    let todayMinTemperature: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .white
        lb.backgroundColor = .clear
        return lb
    }()
    
    let todayMaxTemperature: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .white
        lb.backgroundColor = .clear
        return lb
    }()
    
    func setupMinMaxWeather() {
        let stackView = UIStackView(arrangedSubviews: [todayMaxTemperature, todayMinTemperature])
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, paddingtop: 0, left: nil, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: separateView.topAnchor, botpadding: 0, height: 35, width: 70)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "morning")!)
  
        setupViews()
        setupMinMaxWeather()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateCity), name: .choseCity, object: nil)
        
    }
    
    @objc func handleUpdateCity(notification: Notification) {
        let cityVC = notification.object as! SearchCityController
        guard let chosenCity = cityVC.chosenCity else { return }
        searchCityWeather(city: chosenCity)
    }
    
    func searchCityWeather(city: City) {
        let lat = city.coord.lat
        let lon = city.coord.lon
        let urlString = "https://api.darksky.net/forecast/645e6feeac38ecdaac046caf5f0a5f3b/\(lat),\(lon)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else { return }
            do {
                let results = try JSONDecoder().decode(Object.self, from: data)
                guard let t = results.currently?.temperature else { return }
                let temperature = (Int)((t-32)/1.8)
                self.currentlyWeather = results.currently
                if let dataHourly = results.hourly?.data {
                    self.hourWeather = self.forecastHourWeather(data: dataHourly)
                }
                if let dataDaily = results.daily?.data {
                    self.dailyWeather = self.forecastDailyWeather(data: dataDaily)
                }
                DispatchQueue.main.async {
                    self.dayHourWeatherController.reloadData()
                    self.dayDailyWeatherController.reloadData()
                    self.todayLabel.text = "Today"
                    self.todayMaxTemperature.text = Int((self.dailyWeather[0].temperatureMax!-32)/1.8).description
                    self.todayMinTemperature.text = Int((self.dailyWeather[0].temperatureMin!-32)/1.8).description
                    self.descripWeatherLabel.text = self.currentlyWeather?.summary
                    self.cityNameLabel.text = city.name
                    self.tempLabel.text = String(temperature)
                }
            } catch let err {
                print("Err, \(err)")
            }
        }.resume()
    }
    
    func forecastHourWeather(data: [DataHourly]) -> [DataHourly] {
        var forecastWeather = [DataHourly]()
        let limit = 24
        var count = 0
        let currentUnixTime = Date().millisecondsSince1970
        var mark: Int!
        for i in 1...data.count {
            if currentUnixTime < data[i].time! {
                mark = i - 1
                break
            }
        }
        for i in mark...data.count {
            if count < limit {
                let temp = data[i]
                forecastWeather.append(temp)
                count += 1
            }
            else {
                break
            }
        }
        return forecastWeather
    }
    
    func forecastDailyWeather(data: [DataDaily]) -> [DataDaily] {
        var forecastWeather = [DataDaily]()
        for i in 0..<data.count {
            let temp = data[i]
            forecastWeather.append(temp)
        }
        return forecastWeather
    }
    
    fileprivate func setupViews() {
        view.addSubview(cityNameLabel)
        view.addSubview(descripWeatherLabel)
        view.addSubview(tempLabel)
        view.addSubview(cenciusLabel)
        view.addSubview(accessoryView)
        view.addSubview(separateView)
        view.addSubview(separateViewBot1)
        view.addSubview(separateViewBot2)
        view.addSubview(todayLabel)
        accessoryView.addSubview(choseCityButton)
        
        cityNameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingtop: 50, left: view.leftAnchor, paddingleft: 8, right: view.rightAnchor, paddingright: -8, bot: nil, botpadding: 0, height: 50, width: 0)
        descripWeatherLabel.anchor(top: cityNameLabel.bottomAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 8, right: view.rightAnchor, paddingright: -8, bot: nil, botpadding: 0, height: 20, width: 0)
        
        tempLabel.anchor(top: descripWeatherLabel.bottomAnchor, paddingtop: 20, left: nil, paddingleft: 8, right: nil, paddingright: -8, bot: nil, botpadding: 0, height: 130, width: 160)
        tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cenciusLabel.anchor(top: tempLabel.topAnchor, paddingtop: 0, left: tempLabel.rightAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: -8, bot: nil, botpadding: 0, height: 70, width: 0)
        accessoryView.anchor(top: nil, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: view.safeAreaLayoutGuide.bottomAnchor, botpadding: 0, height: 50, width: 0)
        choseCityButton.anchor(top: accessoryView.topAnchor, paddingtop: 0, left: nil, paddingleft: 0, right: accessoryView.rightAnchor, paddingright: -8, bot: accessoryView.bottomAnchor, botpadding: 0, height: 0, width: 50)
        separateView.anchor(top: tempLabel.bottomAnchor, paddingtop: 80, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 0.5, width: 0)
        todayLabel.anchor(top: nil, paddingtop: 0, left: view.leftAnchor, paddingleft: 16, right: nil, paddingright: 0, bot: separateView.topAnchor, botpadding: 0, height: 35, width: 150)
        
        view.addSubview(dayHourWeatherController)
        dayHourWeatherController.delegate = self
        dayHourWeatherController.dataSource = self
        if let layout = dayHourWeatherController.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
        dayHourWeatherController.register(HourWeatherCell.self, forCellWithReuseIdentifier: cellHourID)
        dayHourWeatherController.anchor(top: separateView.bottomAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 112, width: 0)
        dayHourWeatherController.backgroundColor = .clear
        
        separateViewBot1.anchor(top: dayHourWeatherController.bottomAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: nil , botpadding: 0, height: 0.5, width: 0)
        
        view.addSubview(dayDailyWeatherController)
        dayDailyWeatherController.delegate = self
        dayDailyWeatherController.dataSource = self
        dayDailyWeatherController.register(DailyWeatherCell.self, forCellWithReuseIdentifier: cellForecastID)
        dayDailyWeatherController.register(SummaryDailyCell.self, forCellWithReuseIdentifier: cellSummaryID)
        dayDailyWeatherController.register(CurrentWeatherCell.self, forCellWithReuseIdentifier: currentWeatherID)
        dayDailyWeatherController.anchor(top: dayHourWeatherController.bottomAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: accessoryView.topAnchor, botpadding: 0, height: 0, width: 0)
        dayDailyWeatherController.backgroundColor = .clear
        
        separateViewBot2.anchor(top: dayDailyWeatherController.bottomAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 0.5, width: 0)
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dayHourWeatherController {
            return hourWeather.count
        }
        else {
            if dailyWeather.count == 0 {
                return 0
            }
            else {
                return 9
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.dayHourWeatherController {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellHourID, for: indexPath) as! HourWeatherCell
            cell.backgroundColor = .clear
            cell.hourweather = hourWeather[indexPath.item]
            return cell
        }
        else {
            if indexPath.item < 7 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellForecastID, for: indexPath) as! DailyWeatherCell
                cell.backgroundColor = .clear
                cell.dailyweather = dailyWeather[indexPath.item + 1]
                return cell
            }
            else {
                if indexPath.item == 7 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellSummaryID, for: indexPath) as! SummaryDailyCell
                    cell.backgroundColor = .clear
                    cell.todayWeather = dailyWeather[0]
                    return cell
                }
                else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: currentWeatherID, for: indexPath) as! CurrentWeatherCell
                    cell.backgroundColor = .clear
                    cell.dailyweather = dailyWeather[0]
                    cell.currentweather = currentlyWeather
                    return cell
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.dayHourWeatherController {
            return CGSize(width: 80, height: collectionView.frame.height - 2)
        }
        else {
            if indexPath.item < 7 {
                return CGSize(width: view.frame.width, height: 35)
            }
            else {
                if indexPath.item == 7 {
                    return CGSize(width: view.frame.width, height: 60)
                }
                else {
                   return CGSize(width: view.frame.width, height: 215)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
