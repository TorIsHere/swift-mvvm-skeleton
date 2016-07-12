//
//  ViewController.swift
//  swift-mvvm-skeleton
//
//  Created by Kittikorn Ariyasuk on 7/5/2559 BE.
//  Copyright © 2559 Kittikorn Ariyasuk. All rights reserved.
//

import UIKit
import ReactiveCocoa


class UserViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    dynamic var userViewModel:UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userViewModel = UserViewModel()
        self.bindingViewModel()
        
        if let json = mockReadJSON() {
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue())  { [weak self] in
                if let weakSelf = self {
                    weakSelf.userViewModel = UserViewModel(json: json)
                    weakSelf.bindingViewModel()
                }
            }
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

    func bindingViewModel() {
        self.rac_valuesForKeyPath("userViewModel", observer: self).subscribeNext({ [weak self] (next:AnyObject!) in
            if let weakSelf = self {
                if let nextVal = next as? UserViewModel {
                    if let firstName = nextVal.firstName {
                        weakSelf.firstNameLabel.text = firstName
                    }
                    if let lastName = nextVal.lastName {
                        weakSelf.lastNameLabel.text = lastName
                    }
                    if let sexString = nextVal.sexText {
                        weakSelf.sexLabel.text = sexString
                    }
                    if let ageText = nextVal.ageText {
                        weakSelf.ageLabel.text = ageText
                    }
                    if let profileImage = nextVal.profileImage {
                        weakSelf.profileImageView.image = profileImage
                    }
                }
            }
        })
        
        self.userViewModel.rac_valuesForKeyPath("firstName", observer: self.userViewModel).subscribeNext { [weak self] (next:AnyObject!) in
            if let weakSelf = self {
                if let nextVal = next as? String {
                    weakSelf.firstNameLabel.text = nextVal
                }
            }
        }
        
        self.userViewModel.rac_valuesForKeyPath("lastName", observer: self.userViewModel).subscribeNext { [weak self] (next:AnyObject!) in
            if let weakSelf = self {
                if let nextVal = next as? String {
                    weakSelf.lastNameLabel.text = nextVal
                }
            }
        }
        
        
        self.userViewModel.rac_valuesForKeyPath("sexText", observer: self.userViewModel).subscribeNext { [weak self] (next:AnyObject!) in
            if let weakSelf = self {
                if let nextVal = next as? String {
                    weakSelf.sexLabel.text = nextVal
                }
            }
        }
        
        self.userViewModel.rac_valuesForKeyPath("ageText", observer: self.userViewModel).subscribeNext { [weak self] (next:AnyObject!) in
            if let weakSelf = self {
                if let nextVal = next as? String {
                    weakSelf.ageLabel.text = nextVal
                }
            }
        }
        
        self.userViewModel.rac_valuesForKeyPath("profileImage", observer: self.userViewModel).subscribeNext { [weak self] (next:AnyObject!) in
            if let weakSelf = self {
                if let nextVal = next as? UIImage {
                    weakSelf.profileImageView.image = nextVal
                }
            }
        }

    }

}

