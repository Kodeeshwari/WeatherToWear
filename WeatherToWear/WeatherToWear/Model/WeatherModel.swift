//
//  WeatherModel.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-19.
//

import Foundation
class WeatherModel : Codable{
    var city : String?
    var fromDate : String
    var toDate : String
    var gender : String
    
    init(city : String,fromDate : String,
         toDate : String, gender : String){
        self.city = city
        self.fromDate = fromDate
        self.toDate = toDate
        self.gender = gender
    }
}

