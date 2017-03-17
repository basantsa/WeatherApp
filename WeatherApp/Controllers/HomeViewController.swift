//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Basant Sarda on 17/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: BaseViewController, MapViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var noLocationsAvailable:UILabel?
    @IBOutlet weak var cityListTableView:UITableView?
    var bookmarkedCities = [BookMarkedCity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityListTableView?.tableFooterView = UIView()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextDidSave), name: NSNotification.Name.NSManagedObjectContextDidSave, object: DatabaseManager.sharedInstance.persistentContainer.viewContext)

        self.bookmarkedCities = BookMarkManager.sharedInstance.fetchAllBookMarks()!
        if self.bookmarkedCities.count > 0 {
            self.noLocationsAvailable?.isHidden = true
            self.cityListTableView?.reloadData()
        } else {
            self.noLocationsAvailable?.isHidden = false
        }
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
    @IBAction func viewHelp (sender:UIButton) {
        
    }
    
    //MARK: - TableViewDataSource and Delegates
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.bookmarkedCities.count > 0 {
            return 32
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let sectionView = UIView()
            let label = UILabel(frame: CGRect(x: 10, y: 0, width: self.view.frame.size.width - 10, height: 32))
            label.textColor = UIColor(red: 42/255.0, green: 42/255.0, blue: 42/255.0, alpha: 1.0)
            label.text = "Bookmarked Cities"
            
            sectionView.addSubview(label)
            sectionView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
            return sectionView
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookmarkedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
            cell.bookmarkedCity = self.bookmarkedCities[indexPath.row]
            cell.designCell()
            return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CityViewController") as! CityViewController
            controller.city = self.bookmarkedCities[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
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
        if self.bookmarkedCities.count > 0 {
            self.cityListTableView?.reloadData()
            self.noLocationsAvailable?.isHidden = true
        }
    }


}
