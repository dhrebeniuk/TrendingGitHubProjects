//
//  UIViewExtensions.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable open var corderRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable open var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

}
