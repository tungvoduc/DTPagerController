//
//  CityTableViewCell.swift
//  DTOverlayController_Example
//
//  Created by Tung Vo on 15.6.2019.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
    }

    func populate(from city: City) {
        cityImageView.image = UIImage(named: city.imageName)
        cityNameLabel.text = city.name
    }
}
