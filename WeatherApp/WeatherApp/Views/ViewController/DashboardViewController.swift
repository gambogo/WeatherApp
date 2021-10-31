//
//  DashboardViewController.swift
//  WeatherApp
//
//  Created by Gambogo on 30/10/2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DashboardViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var listWeather: [WeatherDetail] = []
    var dismissKeyboardGesture: UITapGestureRecognizer!
    
    var dashBoardPresenter = DashboardPresenter(service: WeatherService())
    
    let disposeBag = DisposeBag()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Update UI search bar
        locationSearchBar.backgroundImage = UIImage()
        locationSearchBar.layer.borderWidth = 0
        locationSearchBar.layer.borderColor = UIColor.clear.cgColor
        dashBoardPresenter.setViewDelegate(viewDelegate: self)
        dashBoardPresenter.onViewLoaded()
        
        self.weatherTableView.register(UINib(nibName: WeatherTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        //Trigger search location without press search
//        locationSearchBar
//            .rx.text
//            .debounce(RxTimeInterval.seconds(1) , scheduler: MainScheduler.instance) //Wait for 1 sencond after user input
//            .subscribe(onNext: { [unowned self] query in
//                if let strongQuery = query, strongQuery.count > 0 {
//                    if validSearch(search: strongQuery) {
//                        dashBoardPresenter.searchWeather(cityName: strongQuery)
//                    }
//                }
//            })
//            .disposed(by: disposeBag)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dashBoardPresenter.onViewAppeared()
        view.addGestureRecognizer(self.dismissKeyboardGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        dashBoardPresenter.onViewDisappeared()
        view.removeGestureRecognizer(self.dismissKeyboardGesture)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
        self.locationSearchBar.resignFirstResponder()
    }
    
    func validSearch(search: String) -> Bool {
        if search.count < 3 {
            let alert = UIAlertController(title: "", message: "The Search Location must be at least 3 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
        
    }
    
    //MARK: - Searchbar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let strongSearchText  = locationSearchBar.text, strongSearchText.count > 0 {
            
            if validSearch(search: strongSearchText) {
                dashBoardPresenter.searchWeather(cityName: strongSearchText)
            }
        }
        dismissKeyboard()
    }
    
    //MARK: - Presenter Delegates
    
    func searchComplete(result: Weather?) {
        if let strongResult = result {
            if let strongCity = strongResult.city {
                self.cityLabel.text = strongCity.name
            }
            self.listWeather = strongResult.list ?? []
        }
        
        self.weatherTableView.reloadData()
    }
    
    //MARK: - TABLE DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listWeather.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 378
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        
        //Transparent selected background
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        //Data binding
        let currentWeatherDetail = listWeather[indexPath.row]
        
        cell.dateLabel.text = "Date: " + WeatherUtils.dateStringFromTimeStamp(timeStamp: Double(currentWeatherDetail.dt ?? 0))
        
        if let strongTemp = currentWeatherDetail.temp {
            
            cell.tempuratureLabel.text = String(format: "%.1f", ((strongTemp.min ?? 0) + (strongTemp.max ?? 0)) / 2) + "\u{00B0}C"
        } else {
            cell.tempuratureLabel.text = ""
        }
        
        if let strongHumidity  = currentWeatherDetail.humidity {
            cell.humidityLabel.text = "Humidity: " + String(strongHumidity)
        } else {
            cell.humidityLabel.text = "Humidity: "
        }
        
        if let strongPressure  = currentWeatherDetail.pressure {
            cell.pressureLabel.text = "Pressure: " + String(strongPressure)
        } else {
            cell.pressureLabel.text = "Pressure: "
        }
        
        //Cache Image
        if let strongWeather = currentWeatherDetail.weather, strongWeather.count > 0 {
            
            if let strongDescription  = strongWeather[0].description {
                cell.descriptionLabel.text = "Description: " + String(strongDescription)
            } else {
                cell.descriptionLabel.text = "Description: "
            }
            
            if let strongIcon = strongWeather[0].icon {
                cell.weatherImageView.sd_setImage(with: URL(string: WeatherUtils.getImageUrlByName(imageName: strongIcon)), completed: nil)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
