//
//  DashboardPresenter.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation

protocol DashboardViewDelegate: NSObjectProtocol {
    func searchComplete(result: Weather?)
}

class DashboardPresenter {
    private let weatherService: WeatherService
    weak private var dashboardViewDelegate : DashboardViewDelegate?
    
    init(service: WeatherService){
        self.weatherService = service
    }
    
    func setViewDelegate(viewDelegate: DashboardViewDelegate?){
        self.dashboardViewDelegate = viewDelegate
    }
    
    func searchWeather(cityName: (String)) {
        weatherService.searchWeather(country: cityName) { [weak self] result in
            if let strongSelf = self, let strongDelegate = strongSelf.dashboardViewDelegate {
                strongDelegate.searchComplete(result: result)
            }
        }
    }
}
