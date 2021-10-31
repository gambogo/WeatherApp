//
//  AppDelegateMock.swift
//  WeatherAppTests
//
//  Created by Gambogo on 31/10/2021.
//

import Foundation
import UIKit
@testable import WeatherApp

class AppDelegateMock: WeatherApp.AppDelegate {
    
    private(set) var isDiscardedSceneSession = false
    private(set) var isConfigurationForConnecting = false
    
    override func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        super.application(application, didDiscardSceneSessions: sceneSessions)
        isDiscardedSceneSession = true
    }
    
    
}
