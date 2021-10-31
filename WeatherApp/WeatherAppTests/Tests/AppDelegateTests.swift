//
//  AppDelegateTests.swift
//  WeatherAppTests
//
//  Created by Gambogo on 31/10/2021.
//

import XCTest
import Foundation
import UIKit
import Alamofire
@testable import WeatherApp

class AppDelegateTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDidDiscardSceneSessions() throws {
        var mockAppDelegate = AppDelegateMock()
        mockAppDelegate.application(UIApplication.shared, didDiscardSceneSessions: Set())
        
        XCTAssertTrue(mockAppDelegate.isDiscardedSceneSession)
    }
    
   

}
