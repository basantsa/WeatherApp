//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Basant Sarda on 17/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate {
    func didSelectLocation()
}

class MapViewController: BaseViewController {
    @IBOutlet weak var mapView:MKMapView?
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView?
    
    var mapViewControllerDelegate:MapViewControllerDelegate?
    var coordinates:CLLocationCoordinate2D?
    var annotationTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        //for testing
        Forecast().getForecast("18.5204", "73.8567") { (success, forecast) in
            if success {
                print(forecast!)
            }
        }
 */
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.addAnnotation(gestureRecognizer:)))
        longPress.minimumPressDuration = 1.0
        mapView?.addGestureRecognizer(longPress)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method for adding annotation to show the user where he has clicked.
    func addAnnotation(gestureRecognizer:UIGestureRecognizer) {
        if self.mapView!.annotations.count > 0 {
            self.mapView?.removeAnnotations(self.mapView!.annotations)
        }
        self.activityIndicator?.startAnimating()
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            coordinates = mapView?.convert(touchPoint, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates!
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!), completionHandler: { (placemarks, error) -> Void in
                if error == nil {
                    var placeMark: CLPlacemark!

                    placeMark = placemarks?[0]
                    if let city = placeMark.addressDictionary!["City"] as? String {
                        self.annotationTitle = city
                    }
                    if let country = placeMark.addressDictionary!["Country"] as? String {
                        if self.annotationTitle != "" {
                            self.annotationTitle = self.annotationTitle + ", " + country
                        } else {
                            self.annotationTitle = country
                        }
                    }
                    
                    annotation.title = self.annotationTitle
                    self.mapView?.addAnnotation(annotation)
                    self.activityIndicator?.stopAnimating()
                } else {
                    self.activityIndicator?.stopAnimating()
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
            })
            
            
        }
    }

    //MARK: - Actions
    @IBAction func done(sender:UIButton) {
        if self.coordinates == nil || self.annotationTitle == "" {
            self.showAlert("", "Please long press on the map to select a city.")
        } else {
            
            //this means user has selected a valid city, store in in coredata. And reload the Home table.
            //String(format: "%.2f", currentRatio)
            BookMarkManager.sharedInstance.bookmarkCity(annotationTitle, String(format:"%.2f", (self.coordinates?.latitude)!), String(format:"%.2f", (self.coordinates?.longitude)!))
            self.mapViewControllerDelegate?.didSelectLocation()
            _ = self.navigationController?.popViewController(animated: true)
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
