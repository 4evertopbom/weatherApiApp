//
//  SearchCityCell.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 3/28/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class SearchCityCell: UICollectionViewCell {
    
    var city: City? {
        didSet {
            citynameLabel.text = city?.name
        }
    }
    
    let citynameLabel: UILabel = {
        let label = UILabel()
        label.text = "city name"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(citynameLabel)
        citynameLabel.anchor(top: topAnchor, paddingtop: 0, left: leftAnchor, paddingleft: 8, right: rightAnchor, paddingright: -8, bot: bottomAnchor, botpadding: 0, height: 0, width: 0)
        let separatorView = UIView()
        addSubview(separatorView)
        separatorView.backgroundColor = .black
        separatorView.anchor(top: nil, paddingtop: 0, left: citynameLabel.leftAnchor, paddingleft: 0, right: citynameLabel.rightAnchor, paddingright: 0, bot: bottomAnchor, botpadding: 0, height: 0.5, width: 0 )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
