//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation
import Alamofire

class WeatherService {
    
    var requestTimes: [String: TimeInterval] = [:]
    
    private let manager: Session
    init(manager: Session = Session.default) {
        self.manager = manager
    }
    
    func searchWeather(country: (String), callBack: @escaping (Weather?) -> Void) {
        
        let queryUrlBuilder = NSMutableString(string: APIConstant.WeatherHost)
        queryUrlBuilder.append("/data/2.5/forecast/daily?q=")
        queryUrlBuilder.append(country)
        queryUrlBuilder.append("&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric")
        
        let urlReqestString = String(queryUrlBuilder)
        var requesUrl = URLRequest(url: URL(string: urlReqestString)!)
        requesUrl.httpMethod = "GET"
        requesUrl.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //requesUrl.setValue("Cache-Control", forHTTPHeaderField: "max-age=180") //cache for 3 minutes
        
        requesUrl.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad //force load response cached
        
        //If more than 3 minutes
        let timeStamp = NSDate().timeIntervalSince1970
        if let requestTime = requestTimes[urlReqestString] {
            if (timeStamp - requestTime > 180) { //180 seconds
                
                //Or clear all cache if you want
                //URLCache.shared.removeAllCachedResponses()
                
                //Remove cache
                URLCache.shared.removeCachedResponse(for: requesUrl)
            }
        } else {
            requestTimes[urlReqestString] = timeStamp
        }
        
        
        let request = manager.request(requesUrl)
        
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
