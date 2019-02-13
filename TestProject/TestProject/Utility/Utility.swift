//
//  Utility.swift
//  TestProject
//
//  Created by Shubham on 08/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    //Function to formate date
    class func getFormatedDate(_ date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterOut.string(from: date)
        } else {
            print("There was an error decoding the string")
            return ""
        }
    }
    
}


