//
//  String+Ext.swift
//  TestProject
//
//  Created by Shubham on 09/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
