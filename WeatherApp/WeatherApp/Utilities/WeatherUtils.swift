//
//  WeatherUtils.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation

class WeatherUtils {
    
    
    static func getImageUrlByName(imageName: String) -> String {
        let queryUrlBuilder = NSMutableString(string: APIConstant.WeatherHost)
        queryUrlBuilder.append("/img/w/")
        queryUrlBuilder.append(imageName)
        queryUrlBuilder.append(".png")
        return String(queryUrlBuilder)
    }
    
    static func dateStringFromTimeStamp(timeStamp: Double) -> String {
        //Date label
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEE, dd MMM yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
