//
//  WeatherDataDetail.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-19.
//

import Foundation

class WeatherDataDetail: Codable {
    var city: String
    var gender: String
    var days: [WeatherDay]
    
    enum CodingKeys: String, CodingKey {
        case city, gender, days
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.days = try container.decode([WeatherDay].self, forKey: .days)
    }
    
    static func decode( json : [String:Any]!) -> WeatherDataDetail? {

        let decoder = JSONDecoder()
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(WeatherDataDetail.self, from: data)
            return object
        } catch{
        }
        return nil
    }
}
