//
//  PlayerViewModel.swift
//  swift-mvvm-skeleton
//
//  Created by Kittikorn Ariyasuk on 7/5/2559 BE.
//  Copyright © 2559 Kittikorn Ariyasuk. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class UserViewModel: NSObject {

    var userModel:UserModel!
    
    dynamic var profileImage:UIImage!
    dynamic var firstName: String!
    dynamic var lastName: String!
    dynamic var sexText: String!
    dynamic var ageText: String!
    
    override init() {
        super.init()
        self.userModel = UserModel()
    }
    
    convenience init(json:[String: AnyObject]) {
        self.init()
        self.userModel = UserModel(json: json)
        
        self.firstName = self.userModel.firstName
        self.lastName = self.userModel.lastName
        
        if let userSex = self.userModel.sex {
            self.sexText = userSex.rawValue
        }
        
        self.ageText = String(self.userModel.age)
        
        Alamofire.request(.GET, self.userModel.imgUrl)
            .responseImage { response in
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    self.profileImage = image
                }
        }
        
    }
}
