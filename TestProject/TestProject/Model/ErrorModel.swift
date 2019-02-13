//
//  ErrorModel.swift
//  TestProject
//
//  Created by Shubham on 09/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

//Error model to parse error response
struct ErrorModel: Decodable {
    var code: String
    var error: String
    
    init(code: String = "", error: String) {
        self.code = ""
        self.error = error
    }
}
