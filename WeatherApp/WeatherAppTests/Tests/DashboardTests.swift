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

class DashboardTests: XCTestCase, WeatherApp.DashboardViewDelegate {
   
    
    
    var dashboardPresenter: DashboardPresenterMock?
    var weatherService: WeatherApp.WeatherService?
    private var searchExpectation: XCTestExpectation?
    private var weatherFound: WeatherApp.Weather?
    
    private var dashboardViewController: WeatherApp.DashboardViewController?
    
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
        
        weatherService = WeatherApp.WeatherService()
        dashboardPresenter = DashboardPresenterMock(service: weatherService!)
//        dashboardPresenter?.setViewDelegate(viewDelegate: self)
        
        dashboardViewController = makeDashBoardViewController(presenter: dashboardPresenter!)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dashboardPresenter?.setViewDelegate(viewDelegate: nil)
    }
    
    func testSearchComplete(result: Weather?) throws{
        XCTAssertTrue(result != nil)
    }
    
    
    func testViewDidload() throws {
        dashboardViewController?.viewDidLoad()
        XCTAssertTrue(dashboardPresenter!.onViewLoadedCalled)
    }
    
    func testViewDidAppeared() throws {
        dashboardViewController?.viewDidAppear(true)
        XCTAssertTrue(dashboardPresenter!.isAppeared)
    }
    
    func testViewDidDisappeared() throws {
        dashboardViewController?.viewDidDisappear(true)
        XCTAssertTrue(!dashboardPresenter!.isAppeared)
    }
    
    func testSearchWeather() throws {

        searchExpectation = XCTestExpectation(description: "Search city")
        
        weatherService?.searchWeather(country: "saigon", callBack: { result in
            //self.dashboardViewController?.searchComplete(result: result)
            self.weatherFound = result
            self.searchExpectation!.fulfill()
        })
        
        wait(for: [searchExpectation!], timeout: 2)
        XCTAssertTrue(self.weatherFound != nil)
        
        //Test Render items
        dashboardViewController?.listWeather = self.weatherFound?.list ?? []
        dashboardViewController?.weatherTableView.reloadData()
        
        let tableView = dashboardViewController!.weatherTableView!
        let indexPath0 = IndexPath(item: 0, section: 0)
       
        let cell0 = tableView.cellForRow(at: indexPath0) as! WeatherApp.WeatherTableViewCell
       
        let visibleRows = tableView.indexPathsForVisibleRows
        XCTAssert(visibleRows != nil)
        
    }
    
    func testSearchButton() throws {
        
        searchExpectation = XCTestExpectation(description: "Search city from search button")
        dashboardPresenter?.setViewDelegate(viewDelegate: self)
        
        dashboardViewController!.locationSearchBar!.text = "ha"
        dashboardViewController?.searchBarSearchButtonClicked(dashboardViewController!.locationSearchBar!)
        XCTAssertTrue(dashboardViewController!.locationSearchBar!.text!.count < 3)
        
        dashboardViewController!.locationSearchBar!.text = "hanoi"
        dashboardViewController?.searchBarSearchButtonClicked(dashboardViewController!.locationSearchBar!)
        wait(for: [searchExpectation!], timeout: 2)
        XCTAssertTrue(weatherFound!.city!.name!.lowercased() == "hanoi")
    }
    
    //MARK: - Dashboard View Controller
    func makeDashBoardViewController(presenter: WeatherApp.DashboardPresenter) -> WeatherApp.DashboardViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self.classForCoder))
        let sut = storyboard.instantiateViewController(identifier: "DashboardVCID")
        let dashBoardVC = sut as! WeatherApp.DashboardViewController
        dashBoardVC.dashBoardPresenter = presenter
        dashBoardVC.loadViewIfNeeded()
        return dashBoardVC
    }
    
    //MARK: - Dashboard View Delegate
    
    
    func searchComplete(result: WeatherApp.Weather?) {
        weatherFound = result
        searchExpectation?.fulfill()
    }
    
}
