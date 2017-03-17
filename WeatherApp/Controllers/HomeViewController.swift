//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Basant Sarda on 17/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var noLocationsAvailable:UILabel?
    @IBOutlet weak var cityListTableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityListTableView?.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Actions
    @IBAction func addNewLocation (sender:UIButton) {
        
    }
    
    @IBAction func viewHelp (sender:UIButton) {
        
    }

}
