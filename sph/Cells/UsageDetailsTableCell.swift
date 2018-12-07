//
//  UsageDetailsTableCell.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import UIKit

class UsageDetailsTableCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertButton: UIButton!
    
    func setUpCardView() {
        self.cardView.layer.cornerRadius = 5.0
        self.cardView.layer.borderColor  =  UIColor.lightGray.cgColor
        self.cardView.layer.borderWidth = 0.5
        self.cardView.layer.shadowOpacity = 0.5
        self.cardView.layer.shadowColor =  UIColor.lightGray.cgColor
        self.cardView.layer.shadowRadius = 5.0
        self.cardView.layer.shadowOffset = CGSize(width:5, height: 5)
    }
    

}
