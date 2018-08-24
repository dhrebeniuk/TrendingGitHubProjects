//
//  AvatarImageView.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {

    @IBInspectable open var corderRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

}
