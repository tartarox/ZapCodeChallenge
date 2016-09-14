//
//  ImmobileObject.swift
//  ZapCodeChallenge
//
//  Created by Fabio Yudi Takahara on 13/09/16.
//  Copyright © 2016 Fabio Yudi Takahara. All rights reserved.
//

import UIKit

class ImmobileObject: NSObject {
    
    //Immobile Code
    var code = 0
    
    //Address
    var neighborhood = ""
    var cep = ""
    var city = ""
    var complement = ""
    var state = ""
    var address = ""
    var number = ""

    //Photos
    var mainImage = ""
    var backgroundImage = UIImage.init()
    var photoArray = []
    
    //Immobile
    var locationPrice = 0
    var sellPrice = 0
    var subTypeImmobile = ""
    var immobileType = ""
    var zapId = ""
    
    //Manages
    var fullAddress = ""
    var locationString = "LOCAÇÃO"
    
    
}

class ImmobileDetailObject: NSObject {
    
    //Immobile Code
    var area = 0
    var areaUtil = 0
    var sleepRoom = 0
    var suits = 0
    var carSeats = 0
    
}

class PhotoObject: NSObject {
    
    var codImobiliaria = 0
    var photoDescription = ""
    var origin = ""
    var main = false
    var imageUrl = ""
    
}
