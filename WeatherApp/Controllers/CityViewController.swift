//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Basant Sarda on 18/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit

class CityViewController: BaseViewController {

    @IBOutlet weak var cityNameLabel:UILabel!
    var city:BookMarkedCity!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView?
    @IBOutlet weak var weatherInfo:UILabel?
    @IBOutlet weak var temperatureLabel:UILabel?
    @IBOutlet weak var humidityLabel:UILabel?
    @IBOutlet weak var rainChanceLabel:UILabel?
    @IBOutlet weak var windInfo:UILabel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityNameLabel.text = city.cityName
        // Do any additional setup after loading the view.
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchData() {
        self.activityIndicator?.startAnimating()
        Forecast().getForecast(city.latitude!, city.longitude!) { (success, forecast) in
            DispatchQueue.main.async {
                if success {
                    print(forecast!)
                    
                    if forecast?.weatherMain != nil {
                        self.weatherInfo?.text = forecast?.weatherMain
                    } else {
                        self.weatherInfo?.text = "-"
                    }
                    
                    self.temperatureLabel?.text = (forecast?.temp)! + " ℃"
                    
                    if forecast?.humidity != nil {
                        self.humidityLabel?.text = forecast?.humidity
                    } else {
                        self.humidityLabel?.text = "-"
                    }
                    self.rainChanceLabel?.text = forecast?.weatherDesc
                    if forecast?.windSpeed != nil && forecast?.windDegrees != nil {
                        self.windInfo?.text = (forecast?.windSpeed)! + "kn @ " + (forecast?.windDegrees)! + "°"
                    } else {
                        self.windInfo?.text = "-"
                    }
                }
                else {
                    self.showAlert("", "Unable to fetch weather details.")
                }
                self.activityIndicator?.stopAnimating()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
