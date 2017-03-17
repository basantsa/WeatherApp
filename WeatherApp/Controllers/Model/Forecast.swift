//
//  Forecast.swift
//  WeatherApp
//
//  Created by Basant Sarda on 17/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit

class Forecast: NSObject {
    var weatherMain:String?
    var weatherDesc:String?
    
    var temp:String?
    var pressure:String?
    var humidity:String?
    var temp_min:String?
    var temp_max:String?
    var sea_level:String?
    var grnd_level:String?
    
    var windSpeed:String?
    var windDegrees:String?
    
    var country:String?
    var sunrise:Date?
    var sunset:Date?
    
    var cityName:String?
    
    
    func getForecast (_ latitude:String, _ longitude:String,completion : @escaping (_ success:Bool,_ forecast: Forecast?)-> Void)  {
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=" + latitude + "&lon=" + longitude + "&appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
        
        NetworkManager.sharedInstance.getDataFromUrl(url: url, success: { (response) in
            do {
                let json = try JSONSerialization.jsonObject(with: response, options: []) as! Dictionary<String, Any>
                print(json)
                completion(true,self.parseForecastDict(dict: json))
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                completion(false, nil)
            }
        }) { (error) in
            if error != nil {
                print(error!.description)
            }
        }
    }
    
    
    func parseForecastDict(dict:Dictionary<String, Any>) -> Forecast {
        let forecast = Forecast()
        if let weatherArray =  dict["weather"] as? Array<Dictionary<String,Any>> {
            if weatherArray.count > 0 {
                let weatherDict = weatherArray[0]
                if let weatherMain = weatherDict["main"] as? String {
                    forecast.weatherMain = weatherMain
                }
                if let weatherDesc = weatherDict["description"] as? String {
                    forecast.weatherDesc = weatherDesc
                }
            }
        }
        
        if let mainWeatherDetails =  dict["main"] as? Dictionary<String,Any> {
            if let grnd_level = mainWeatherDetails["grnd_level"] as? Double {
                forecast.grnd_level = String(grnd_level)
            }
            
            if let humidity = mainWeatherDetails["humidity"] as? Int {
                forecast.humidity = String(humidity)
            }
            
            if let pressure = mainWeatherDetails["pressure"] as? Double {
                forecast.pressure = String(pressure)
            }
            
            if let sea_level = mainWeatherDetails["sea_level"] as? Double {
                forecast.sea_level = String(sea_level)
            }
            
            if let temp = mainWeatherDetails["temp"] as? Double {
                forecast.temp = String(temp)
            }
            
            if let temp_max = mainWeatherDetails["temp_max"] as? Double {
                forecast.temp_max = String(temp_max)
            }
            
            if let temp_min = mainWeatherDetails["temp_min"] as? Double {
                forecast.temp_min = String(temp_min)
            }
        }
        
        if let windDetails =  dict["wind"] as? Dictionary<String,Any> {
            if let windDegrees = windDetails["deg"] as? Double {
                forecast.windDegrees = String(format:"%.1f",windDegrees)
            }
            
            if let windSpeed = windDetails["speed"] as? Double {
                forecast.windSpeed = String(windSpeed)
            }

        }

        if let sysDetails =  dict["sys"] as? Dictionary<String,Any> {
            if let sunrise = sysDetails["sunrise"] as? Int {
                forecast.sunrise = Date(timeIntervalSince1970: TimeInterval(sunrise))
            }
            
            if let sunset = sysDetails["sunset"] as? Int {
                forecast.sunset = Date(timeIntervalSince1970: TimeInterval(sunset))
            }
            
            if let country = sysDetails["country"] as? String {
                forecast.country = country
            }
            
        }
        
        if let cityName =  dict["name"] as? String {
            forecast.cityName = cityName
        }
        return forecast
    }
    
}
