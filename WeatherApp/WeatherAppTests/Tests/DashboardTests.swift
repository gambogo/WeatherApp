//
//  DashboardTests.swift
//  WeatherAppTests
//
//  Created by Gambogo on 31/10/2021.
//

import XCTest
import Foundation
import UIKit
import Alamofire
@testable import WeatherApp

class DashboardTests: XCTestCase, DashboardViewDelegate {
  
    
    var dashboardPresenter: DashboardPresenter?
    var weatherService: WeatherService?
    private var searchExpectation: XCTestExpectation?
    private var weatherFound: Weather?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        //Incase we need to mock response data
        //        let manager: Session = {
        //            let configuration: URLSessionConfiguration = {
        //                let configuration = URLSessionConfiguration.default
        //                configuration.protocolClasses = [MockURLProtocol.self]
        //                return configuration
        //            }()
        //
        //            return Session(configuration: configuration)
        //        }()
        //        weatherService = WeatherService(manager: manager)
        
        weatherService = WeatherService()
        dashboardPresenter = DashboardPresenter(service: weatherService!)
        dashboardPresenter?.setViewDelegate(viewDelegate: self)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dashboardPresenter?.setViewDelegate(viewDelegate: nil)
    }
    
    func testSearchComplete(result: Weather?) throws{
        XCTAssertTrue(result != nil)
    }
    
    
    func testSearchWeather() throws {
        
        searchExpectation = XCTestExpectation(description: "Search city")
        
        dashboardPresenter?.searchWeather(cityName: "saigon")
        wait(for: [searchExpectation!], timeout: 100)
    }
    
    //MARK: - Dashboard View Delegate
    func searchComplete(result: Weather?) {
        weatherFound = result
        searchExpectation?.fulfill()
    }
    
}
