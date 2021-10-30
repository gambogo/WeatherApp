//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation
import Alamofire

class WeatherService {
    
   
    
    
    func searchWeather(country: (String), callBack: @escaping (Weather?) -> Void) {
        
        let queryUrlBuilder = NSMutableString(string: APIConstant.WeatherHost)
        queryUrlBuilder.append("/data/2.5/forecast/daily?q=")
        queryUrlBuilder.append(country)
        queryUrlBuilder.append("&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric")
        
        let request = AF.request(String(queryUrlBuilder))
        request.responseJSON { (response) in
            do {
                if response != nil && response.data != nil {
                    let data = try? JSONDecoder().decode(Weather.self, from: response.data!)
                    
                    callBack(data)
                } else {
                    callBack(nil)
                }
                
            }
            catch {
                callBack(nil)
            }
            
            
            
        }
        
    }
}
