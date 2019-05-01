//
//  ChoseCityController.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/27/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class SearchCityController: UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var check = 5

    lazy var cancelSearchButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Cancel", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.addTarget(self, action: #selector(handleCancelSearch), for: .touchUpInside)
        return bt
    }()

    @objc func handleCancelSearch() {
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }

    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.barTintColor = .blue
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return sb

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        check = 0
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "search")!)
        collectionView.register(SearchCityCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag

        setupSearchBar()
    }

    func setupSearchBar() {
        let navBar = navigationController?.navigationBar
        navBar?.addSubview(searchBar)
        navBar?.addSubview(cancelSearchButton)
        
        searchBar.delegate = self
        searchBar.anchor(top: navBar?.topAnchor, paddingtop: 0, left: navBar?.leftAnchor, paddingleft: 8, right: navBar?.rightAnchor, paddingright: -56, bot: navBar?.bottomAnchor, botpadding: 0, height: 0, width: 0)
        cancelSearchButton.anchor(top: searchBar.topAnchor, paddingtop: 0, left: searchBar.rightAnchor, paddingleft: 4, right: navBar?.rightAnchor, paddingright: -3, bot: searchBar.bottomAnchor, botpadding: 0, height: 0, width: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if check == 0 {
            let queue = DispatchQueue(label: "myQueue", qos: .userInitiated)
            queue.async {
                self.cities = self.loadJson(filename: "citylist")!
            }
            check = 1
        }
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenCity = searchCity[indexPath.item]
        didChoseCity()
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }

    func didChoseCity(){
        NotificationCenter.default.post(name: NSNotification.Name.choseCity, object: self)
    }

    var cities = [City]()
    var searchCity = [City]()
    var chosenCity: City?

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            searchCity.removeAll()
        }
        else {
            let limit = 15
            var count = 0
            searchCity = self.cities.filter({ (city) -> Bool in
                var fetchCity = [City]()
                fetchCity.reserveCapacity(limit)
                if (count < limit) {
                    if city.name.lowercased().contains(searchText.lowercased()) {
                        count += 1
                        return city.name.lowercased().contains(searchText.lowercased())
                    }
                }
                return false
            })
        }
        self.collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCity.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCityCell
        cell.city = searchCity[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }


    fileprivate func loadJson(filename fileName: String) -> [City]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponeData.self, from: data)
                return jsonData.city
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

}
