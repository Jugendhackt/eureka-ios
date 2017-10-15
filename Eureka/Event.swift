//
//  Event.swift
//  Eureka
//
//  Created by Luke Mueller on 14.10.17.
//  Copyright © 2017 Jugend hackt. All rights reserved.
//

import Foundation

class Event {
    let id: String
    let creationDate: Date
    let creatorId: String
    let place: String
    let activityId: String
    let time: Date
    let lang: String
    
    init(id: String, creationDate: Date, creatorId: String, place: String, activityId: String, time: Date, lang: String) {
        self.id = id
        self.creationDate = creationDate
        self.creatorId = creatorId
        self.place = place
        self.activityId = activityId
        self.time = time
        self.lang = lang
    }
    
//    init(eventDict: [String:Any]) {
//        self.id = eventDict["id"] as! String
//        self.creationDate = Date()
//        self.creatorId = eventDict["crtorIdea"] as! String
//        self.place = eventDict["place"] as! String
//        self.activityId = eventDict["activityId"] as! String
//        self.time = Date()
//        self.lang = eventDict["lang"] as! String
//    }
}
