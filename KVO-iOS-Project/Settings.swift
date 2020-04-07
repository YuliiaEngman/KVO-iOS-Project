//
//  Settings.swift
//  KVO-iOS-Project
//
//  Created by Yuliia Engman on 4/7/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

// Settings needs to be KVO-complient
// @objc + inherit from NSOblect
@objc class Settings: NSObject {
    static var shared = Settings()
    @objc dynamic var fontSize: Int
    @objc dynamic var iconName: String
    override private init() {
        fontSize = 17
        iconName = "sun,haze.fill"
    }
}
