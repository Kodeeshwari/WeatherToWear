//
//  WeatherDay.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-19.
//

import Foundation
class WeatherDay: Codable {
    var datetime: String
    var temp: String
    var tempmax: String
    var tempmin: String
    var feelslike: String
    var preciptype: String
    var outfits: [WeatherOutfit]
    
    enum CodingKeys: String, CodingKey {
        case datetime, temp, tempmax, tempmin, feelslike, preciptype, outfits
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.datetime = try container.decode(String.self, forKey: .datetime)
        self.temp = try container.decode(String.self, forKey: .temp)
        self.tempmax = try container.decode(String.self, forKey: .tempmax)
        self.tempmin = try container.decode(String.self, forKey: .tempmin)
        self.feelslike = try container.decode(String.self, forKey: .feelslike)
        self.preciptype = try container.decode(String.self, forKey: .preciptype)
        self.outfits = try container.decode([WeatherOutfit].self, forKey: .outfits)
    }
    
    
}
