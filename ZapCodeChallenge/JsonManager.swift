//
//  jsonManager.swift
//  ZapCodeChallenge
//
//  Created by Fabio Yudi Takahara on 13/09/16.
//  Copyright © 2016 Fabio Yudi Takahara. All rights reserved.
//

import UIKit

class JsonManager: NSObject {
    
    class func getObjectFromJson(jsonName:String) -> NSDictionary {
        
        let fileLocation = NSBundle.mainBundle().pathForResource(jsonName, ofType: "json")!
        var text : String
        do
        {
            text = try String(contentsOfFile: fileLocation)
            let data = text.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                return responseObject

            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            }
        }
        catch
        {
            //Handle Error
            return NSDictionary()
        }
        
        //Handle Error
        return NSDictionary()
    }
}
