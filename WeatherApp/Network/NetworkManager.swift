//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Basant Sarda on 17/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    var requestArray = [URLSessionDataTask]()
    
    func getDataFromUrl(url:String,success: @escaping (Data) -> Void,failure: @escaping (NSError?) -> Void) {
        let defaultSession = URLSession (configuration: URLSessionConfiguration.default)
        var dataTask = URLSessionDataTask()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
        let urlStr = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        let searchURL : NSURL = NSURL(string: urlStr! as String)!
        
        dataTask = defaultSession.dataTask(with: searchURL as URL) {
            data, response, error in
            
            self.requestArray.append(dataTask)
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    success(data!)
                } else {
                    failure(error as? NSError)
                }
            }
        }
        dataTask.resume()
    }
    
    func cancelPendingRequests() {
        for dataReq in requestArray {
            dataReq.cancel()
        }
        requestArray.removeAll()
    }
}
