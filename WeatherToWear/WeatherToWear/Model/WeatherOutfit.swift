//
//  WeatherOutfit.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-19.
//

import Foundation
class WeatherOutfit: Codable {
    var name: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case name, image
    }
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    
}
