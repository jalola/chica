//
//  Model.swift
//  Agile24
//
//  Created by Hung Nguyen on 11/24/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation

import SwiftyJSON

class Item {
    
    var id: String
    var type: String
    var mainDesc: String
    var title: String
    var shortDesc: String
    var images: String
    var contact: String
    
    
    init(json: JSON){
        self.id = json["id"].stringValue
        self.type = json["type"].stringValue
        self.mainDesc = json["description"].stringValue
        self.title = json["title"].stringValue
        self.shortDesc = json["shortDesc"].stringValue
        self.images = json["images"].stringValue
        self.contact = json["contact"].stringValue
    }
}
