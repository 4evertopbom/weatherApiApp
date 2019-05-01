////
////  SearchVC.swift
////  weatherApp
////
////  Created by Hoang Anh Tuan on 4/5/19.
////  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class SearchVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
//    
//    let cellId = "cellId"
//    var cities = [City]()
//    var searchCity = [City]()
//    var chosenCity: City?
//    
//    
//    let containView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.rgb(red: 199, green: 191, blue: 196)
//        return view
//    }()
//    
//    let searchBar: UISearchBar = {
//        let sb = UISearchBar()
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
//        return sb
//    }()
//    
//    lazy var cancelSearchButton: UIButton = {
//        let bt = UIButton(type: .system)
//        bt.setTitle("Cancel", for: .normal)
//        bt.setTitleColor(.black, for: .normal)
//        bt.addTarget(self, action: #selector(handleCancelSearch), for: .touchUpInside)
//        return bt
//    }()
//    
//    @objc func handleCancelSearch() {
//        searchBar.resignFirstResponder()
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    let ResultController: UICollectionView = {
//        let clv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
//        return clv
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "search")!)
//        
//        setupContainView()
//        
//        view.addSubview(ResultController)
//        ResultController.dataSource = self
//        ResultController.delegate = self
//
//        setUpCollectionView()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let queue = DispatchQueue(label: "myQueue", qos: .userInitiated)
//        queue.async {
//            self.cities = self.loadJson(filename: "citylist")!
//        }
//    }
//    
//    func setUpCollectionView() {
//        ResultController.anchor(top: containView.bottomAnchor, paddingtop: 1, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: view.safeAreaLayoutGuide.bottomAnchor, botpadding: 0, height: 0, width: 0)
//        ResultController.register(SearchCityCell.self, forCellWithReuseIdentifier: cellId)
//        ResultController.alwaysBounceVertical = true
//        ResultController.keyboardDismissMode = .interactive
//        ResultController.backgroundColor = .clear
//    }
//    
//    fileprivate func setupContainView() {
//        view.addSubview(containView)
//        containView.anchor(top: view.topAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 80 , width: 0)
//        
//        containView.addSubview(searchBar)
//        searchBar.delegate = self
//        searchBar.anchor(top: nil, paddingtop: 0, left: containView.leftAnchor, paddingleft: 0, right: containView.rightAnchor, paddingright: -56, bot: containView.bottomAnchor, botpadding: 0, height: 40, width: 0)
//        containView.addSubview(cancelSearchButton)
//        cancelSearchButton.anchor(top: searchBar.topAnchor, paddingtop: 0, left: searchBar.rightAnchor, paddingleft: 2, right: containView.rightAnchor, paddingright: -5, bot: searchBar.bottomAnchor, botpadding: 0, height: 0, width: 0)
//        
//        
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if searchText.isEmpty {
//            searchCity.removeAll()
//        }
//        else {
//            let limit = 15
//            var count = 0
//            searchCity = self.cities.filter({ (city) -> Bool in
//                var fetchCity = [City]()
//                fetchCity.reserveCapacity(limit)
//                if (count < limit) {
//                    if city.name.lowercased().contains(searchText.lowercased()) {
//                        count += 1
//                        return city.name.lowercased().contains(searchText.lowercased())
//                    }
//                }
//                return false
//            })
//        }
//        self.ResultController.reloadData()
//    }
//    
//    fileprivate func loadJson(filename fileName: String) -> [City]? {
//        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(ResponeData.self, from: data)
//                return jsonData.city
//            } catch {
//                print("error:\(error)")
//            }
//        }
//        return nil
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return searchCity.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCityCell
//        cell.city = searchCity[indexPath.item]
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 66)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        chosenCity = searchCity[indexPath.item]
//        print(indexPath.item)
//        didChoseCity()
//        searchBar.resignFirstResponder()
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func didChoseCity(){
//        NotificationCenter.default.post(name: NSNotification.Name.choseCity, object: self)
//    }
//}
//
////extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return searchCity.count
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCityCell
////        cell.city = searchCity[indexPath.item]
////        return cell
////    }
////
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: view.frame.width, height: 66)
////    }
////
////    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
////        chosenCity = searchCity[indexPath.item]
////        didChoseCity()
////        searchBar.resignFirstResponder()
////        dismiss(animated: true, completion: nil)
////    }
////
////    func didChoseCity(){
////        NotificationCenter.default.post(name: NSNotification.Name.choseCity, object: self)
////    }
////}
