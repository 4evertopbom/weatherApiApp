//
//  SummaryDailyCell.swift
//  weatherApp
//
//  Created by Hoang Anh Tuan on 4/1/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class SummaryDailyCell: UICollectionViewCell {
    var todayWeather: DataDaily? {
        didSet {
            guard let unwrappedTodayWeather = todayWeather else { return }
            guard let summary = unwrappedTodayWeather.summary else { return }
            DispatchQueue.main.async {
                self.summaryLabel.text = summary
            }
        }
    }
    
    let summaryLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(summaryLabel)
        summaryLabel.anchor(top: topAnchor, paddingtop: 0, left: leftAnchor, paddingleft: 8, right: rightAnchor, paddingright: 0, bot: bottomAnchor, botpadding: 0, height: 0, width: 0)
        
        let separateLineTop = UIView()
        separateLineTop.backgroundColor = .white
        
        let separateLineBot = UIView()
        separateLineBot.backgroundColor = .white
        
        addSubview(separateLineTop)
        addSubview(separateLineBot)
        separateLineTop.anchor(top: topAnchor, paddingtop: 0, left: leftAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: nil, botpadding: 0, height: 0.5, width: 0)
        separateLineBot.anchor(top: nil, paddingtop: 0, left: leftAnchor, paddingleft: 0, right: rightAnchor, paddingright: 0, bot: bottomAnchor, botpadding: 0, height: 0.5, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
