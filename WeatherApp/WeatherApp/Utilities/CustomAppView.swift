//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable class CustomAppView: UIView {

    /// The ratio (from 0.0 to 1.0, inclusive) of the view's corner radius
    /// to its width. For example, a 50% radius would be specified with
    /// `cornerRadiusRatio = 0.5`.
    @IBInspectable var cornerRadiusView: CGFloat {
        get {
            return layer.cornerRadius
        }

        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
            clipsToBounds = true
            
        }
    }

}
