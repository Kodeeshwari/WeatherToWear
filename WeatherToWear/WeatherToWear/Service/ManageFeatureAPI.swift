//
//  ManageFeatureAPI.swift
//  WeatherToWear
//
//  Created by Kodeeshwari Solanki on 2023-04-19.
//

import Foundation

class ManageFeatureAPI{
    
    static let baseURL = "https://weathertowear.000webhostapp.com/"
    
    static func getWeatherData( city : String,
                        fromDate : String,
                        toDate : String,
                        gender : String,
                        successHandler: @escaping (_ httpStatusCode : Int, _ response : [String: Any]) -> Void,
                        failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void) {
        
        let endPoint = "weather.php"
        
       
        let header : [String:String] = [:]

        var payload : [String:Any] = ["city": city, "fromDate" : fromDate,"toDate":toDate,"gender":gender]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: "POST", header: header, payload: payload, successHandler: successHandler, failHandler: failHandler)
        
    }

}
