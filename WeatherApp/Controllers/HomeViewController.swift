//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Basant Sarda on 17/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: BaseViewController, MapViewControllerDelegate {

    @IBOutlet weak var noLocationsAvailable:UILabel?
    @IBOutlet weak var cityListTableView:UITableView?
    var bookmarkedCities = [BookMarkedCity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityListTableView?.tableFooterView = UIView()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextDidSave), name: NSNotification.Name.NSManagedObjectContextDidSave, object: DatabaseManager.sharedInstance.persistentContainer.viewContext)

        self.bookmarkedCities = BookMarkManager.sharedInstance.fetchAllBookMarks()!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MapViewSegue" {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.mapViewControllerDelegate = self
        }
    }
    
    
    //MARK: - Actions
    @IBAction func addNewLocation (sender:UIButton) {
        
    }
    
    @IBAction func viewHelp (sender:UIButton) {
        
    }
    
    //MARK: - MapViewControllerDelegate
    func didSelectLocation() {
        print(self.bookmarkedCities.count)
    }
    
    //CoreData save callback
    func managedObjectContextDidSave() {
        print("data saved in coredata finally")
        self.showAlert("", "City bookmarked.")
        self.bookmarkedCities = BookMarkManager.sharedInstance.fetchAllBookMarks()!
        print(self.bookmarkedCities.count)
    }


}
