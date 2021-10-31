//
//  DashboardPresenterMock.swift
//  WeatherAppTests
//
//  Created by Gambogo on 31/10/2021.
//

import Foundation
@testable import WeatherApp

class DashboardPresenterMock: WeatherApp.DashboardPresenter {
    
    private(set) var onViewLoadedCalled = false
    
    private(set) var isAppeared = false
    
    override func onViewLoaded() {
        onViewLoadedCalled = true
        super.onViewLoaded()
    }
    
    override func onViewAppeared() {
        isAppeared = true
        super.onViewAppeared()
    }
    
    override func onViewDisappeared() {
        isAppeared = false
        super.onViewDisappeared()
    }
    
}
