//
//  ViewController.swift
//  swift-mvvm-skeleton
//
//  Created by Kittikorn Ariyasuk on 7/5/2559 BE.
//  Copyright © 2559 Kittikorn Ariyasuk. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var userViewModel:UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let json = mockReadJSON() {
            userViewModel = UserViewModel(json: json)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mockReadJSON() -> [String:AnyObject]? {
        
        if let path = NSBundle.mainBundle().pathForResource("user", ofType: "json"){
            if let jsonData = NSData(contentsOfFile: path) {
                do {
                    let jsonResult:[String : AnyObject] = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                    return jsonResult
                } catch {
                    print(error)
                }
                
                
            }
        }
        return nil
    }


}

