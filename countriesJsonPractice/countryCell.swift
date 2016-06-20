//
//  countryCell.swift
//  countriesJsonPractice
//
//  Created by Chris Hovey on 6/16/16.
//  Copyright © 2016 Chris Hovey. All rights reserved.
//

import UIKit

class countryCell: UITableViewCell {

    @IBOutlet weak var countryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(country: Country){
        countryLbl.text = country.name
    }
    
}
