//
//  OutfitCollectionViewCell.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-18.
//

import UIKit

class OutfitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var outfitImage: UIImageView!
    
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the height constraint for the outfit image
        let heightConstraint = NSLayoutConstraint(item: outfitImage!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 200)
        heightConstraint.isActive = true
        outfitImage.addConstraint(heightConstraint)
        outfitImage.contentMode = .scaleAspectFit
        outfitImage.translatesAutoresizingMaskIntoConstraints = false
        outfitImage.heightAnchor.constraint(equalTo: outfitImage.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    
    
    
    
}
