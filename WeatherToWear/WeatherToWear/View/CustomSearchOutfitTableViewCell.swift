//
//  CustomSearchOutfitTableViewCell.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-20.
//

import UIKit

class CustomSearchOutfitTableViewCell: UITableViewCell {

    static let identifier = "CustomSearchOutfitTableViewCell"
    
    @IBOutlet weak var outfitImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let heightConstraint = NSLayoutConstraint(item: outfitImgView!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 250)
        heightConstraint.isActive = true
        self.backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCellContent(weatherOutfit : WeatherOutfit){
        
        if let url = URL(string: weatherOutfit.image) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.outfitImgView.image = UIImage(data: data)
                    }
                }
            })
            dataTask.resume()
        }
    }
}
