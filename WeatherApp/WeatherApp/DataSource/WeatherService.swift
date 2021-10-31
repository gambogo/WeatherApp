//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation
import Alamofire

class WeatherService {
    
    private let allowedDiskSize = 100 * 1024 * 1024 //Bytes
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "WeatherServiceCache")
    }()
    
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
        requesUrl.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad //force load response cached
        
        
        //If more than 3 minutes
        let timeStamp = NSDate().timeIntervalSince1970
        if let requestTime = requestTimes[urlReqestString] {
            if (timeStamp - requestTime > 180) { //180 seconds
                
                //Remove cache - The request will be effect next time api call
                self.cache.removeCachedResponse(for: requesUrl)
            }
        } else {
            requestTimes[urlReqestString] = timeStamp
        }
        
        if let cachedData = self.cache.cachedResponse(for: requesUrl) {
            let data = try? JSONDecoder().decode(Weather.self, from: cachedData.data)
            callBack(data)
        } else {
            let request = manager.request(requesUrl)
            
            request.responseJSON { (response) in
                do {
                    
                    if response != nil && response.data != nil {
                        
                        if let urlResponse = response.response {
                            let cachedData = CachedURLResponse(response: urlResponse, data: response.data!)
                           self.cache.storeCachedResponse(cachedData, for: requesUrl)
                        }
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
}
