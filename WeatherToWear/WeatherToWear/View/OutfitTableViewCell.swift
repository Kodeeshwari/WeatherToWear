//
//  OutfitTableViewCell.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-18.
//

import UIKit

class OutfitTableViewCell: UITableViewCell {
    
    static let identifier = "OutfitTableViewCell"
    
    let imagesDictionary: [String: UIImage] = ["rain": UIImage(named: "rain")!, "cloud": UIImage(named: "cloud")!,"snow": UIImage(named: "snow")!,"clear": UIImage(named: "cloud")!]
    
    
    @IBOutlet weak var weatherImageIcon: UIImageView!
    
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setCellContent(weatherDay : WeatherDay ,city : String){
        currentTemp.text = weatherDay.temp
        cityName.text = weatherDay.datetime
        highTemp.text = weatherDay.tempmax
        weatherCondition.text = weatherDay.preciptype
        weatherImageIcon.image = imagesDictionary[weatherDay.preciptype]
    }
    
        
        
        
        
        
        

}
