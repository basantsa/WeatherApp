//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Basant Sarda on 17/03/17.
//  Copyright © 2017 Basant. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var backButtonForNavControl:UIButton?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.navigationController != nil {
            self.navigationController!.isNavigationBarHidden = false
            self.navigationController!.navigationBar.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender:UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func showAlert(_ title:String, _ message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
