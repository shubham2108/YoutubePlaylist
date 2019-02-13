//
//  UIViewController+Alert.swift
//  TestProject
//
//  Created by Shubham on 09/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Display simple alert with title and message and return completion closure
    func showAlert(title: String = ERROR, message: String, completionHandler: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: RETRY, style: .default, handler: { alertAction in
            if let handler = completionHandler {
                handler(alertAction)
            }
        }))
        alertController.addAction(UIAlertAction(title: CANCEL, style: .cancel, handler: { alertAction in
            if let handler = completionHandler {
                handler(alertAction)
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
}


//Show spinner on API call
extension UIViewController {
    
    // Add activity indicator on view
    func displayActivityIndicator(onView : UIView) -> UIView {
        guard let window = view.window else {return UIView()}
        window.isUserInteractionEnabled = false
        let loadingView = UIView(frame: window.bounds)
        loadingView.backgroundColor = .clear
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let spinner = UIActivityIndicatorView.init(style: .gray)
        spinner.center = loadingView.center
        spinner.startAnimating()
        loadingView.addSubview(spinner)
        loadingView.center = window.center
        window.addSubview(loadingView)
        window.bringSubviewToFront(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }
    
    // Remove activity indicator from view
    func removeActivityIndicator(_ view: UIView) {
        self.view.window?.isUserInteractionEnabled = true
        view.removeFromSuperview()
    }
}

