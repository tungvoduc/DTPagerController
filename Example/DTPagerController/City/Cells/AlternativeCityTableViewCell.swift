//
//  AlternativeCityTableViewCell.swift
//  DTOverlayController_Example
//
//  Created by Tung Vo on 17.6.2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class AlternativeCityTableViewCell: UITableViewCell {
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
    }

    func populate(from city: City) {
        cityImageView.image = UIImage(named: city.imageName)
        cityNameLabel.text = city.name
        cityDescriptionLabel.text = city.description
    }
}
