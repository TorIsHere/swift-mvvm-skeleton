//
//  PlayerModel.swift
//  swift-mvvm-skeleton
//
//  Created by Kittikorn Ariyasuk on 7/5/2559 BE.
//  Copyright © 2559 Kittikorn Ariyasuk. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    
    enum Sex: String {
        case female = "female"
        case male = "male"
        case undeclared = "undeclared"
    }
    
    dynamic var userName:String!
    dynamic var firstName:String!
    dynamic var lastName:String!
    dynamic var imgUrl:String!
    dynamic var thumbUrl:String!
    //dynamic var sex:Sex!
    dynamic private(set) var sexRaw: String?
    
    var sex : Sex? {
        didSet {
            sexRaw = sex?.rawValue
        }
    }
    
    dynamic var age:NSNumber!
    dynamic var birthday:NSDate!
    
    override init() {
        super.init()
        self.userName = ""
        self.firstName = ""
        self.lastName = ""
        self.imgUrl = "http://placehold.it/300x300"
        self.thumbUrl = "http://placehold.it/100x100"
        self.sex = Sex.undeclared
        self.age = 1
        self.birthday = NSDate(timeIntervalSince1970: 0)
    }
    
    init(userName: String, firstName: String, lastName: String, imgUrl: String, thumbUrl: String, sex:Sex, age:Int, birthday:NSDate) {
        super.init()
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.imgUrl = imgUrl
        self.thumbUrl = thumbUrl
        self.sex = sex
        self.age = age
        self.birthday = birthday
    }
    
    init(json:[String: AnyObject]) {
        super.init()
        if NSJSONSerialization.isValidJSONObject(json) {
            if let userName = json["user_name"] as! String? {
                self.userName = userName
            }
            if let firstName = json["first_name"] as! String? {
                self.firstName = firstName
            }
            if let lastName = json["last_name"] as! String? {
                self.lastName = lastName
            }
            if let imgUrl = json["img_url"] as! String? {
                self.imgUrl = imgUrl
            }
            if let thumbUrl = json["thumb_url"] as! String? {
                self.thumbUrl = thumbUrl
            }
            if let age = json["age"] as! String? {
                self.age = Int(age)
            }
            if let sexText = json["sex"] as! String? {
                if sexText == "m" {
                    self.sex = Sex.male
                } else if sexText == "f" {
                    self.sex = Sex.female
                } else {
                    self.sex = Sex.undeclared
                }
            }
        }
    }
}
