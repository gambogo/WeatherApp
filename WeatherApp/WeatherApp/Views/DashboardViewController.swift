//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationSearchBar.backgroundImage = UIImage()
        locationSearchBar.layer.borderWidth = 0
        locationSearchBar.layer.borderColor = UIColor.clear.cgColor

        self.weatherTableView.register(UINib(nibName: WeatherTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 378
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell

        return cell
    }


}
