//
//  OutfitModel.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-18.
//

import Foundation

class OutfitModel : Codable{
    var outfitName : String?
    var outfitImageUrl : URL?

    init(outfitName :String, outfitImageUrl :URL){
        self.outfitName = outfitName
        self.outfitImageUrl = outfitImageUrl

    }
}

