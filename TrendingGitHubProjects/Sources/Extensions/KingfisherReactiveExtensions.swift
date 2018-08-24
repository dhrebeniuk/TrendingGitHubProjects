//
//  KingfisherReactiveExtensions.swift
//  TrendingGitHubProjects
//
//  Created by Dmytro Hrebeniuk on 8/24/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

import ReactiveSwift
import ReactiveCocoa
import Kingfisher

extension Reactive  where Base == UIImageView {
    var resource: BindingTarget<Resource?> {
        return makeBindingTarget {
            $0.kf.setImage(with: $1)
        }
    }
}

