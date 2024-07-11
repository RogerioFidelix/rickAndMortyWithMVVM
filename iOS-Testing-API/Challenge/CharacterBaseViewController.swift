//
//  CharacterBaseViewController.swift
//  iOS-Testing-API
//
//  Created by Rogério Fidelix on 20/02/21.
//  Copyright © 2021 Rogério Fidelix. All rights reserved.
//

import Foundation
import UIKit

class CharacterBaseViewController: UIViewController {
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    func showActivityIndicator() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
    }
}
