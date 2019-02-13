//
//  ServiceLayerManager.swift
//  TestProject
//
//  Created by Shubham on 12/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation
import Alamofire

class ServiceLayerManager {
    
    //Check internet connectivity
    private class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    // Handle API response
    class func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, encoding: ParameterEncoding = JSONEncoding.default, completionHandler: @escaping (_ responseData: DataResponse<Any>?, _ error: ErrorModel?) -> ()) {
        // Check Network Connectivity
        if isConnectedToInternet() {
            Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { responseData in
                print(responseData.description)
                if let error = responseData.error {
                    completionHandler(nil, ErrorModel(error: error.localizedDescription))
                }else {
                    completionHandler(responseData, nil)
                }
            }
        }else {
            completionHandler(nil, ErrorModel(error: NO_CONNECTION) )
        }
    }
}

