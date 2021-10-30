//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation
import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    public static let nibName = "WeatherTableViewCell"
    public static let identifier = "WeatherCell"
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempuratureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}
