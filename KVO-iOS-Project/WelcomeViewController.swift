//
//  ViewController.swift
//  KVO-iOS-Project
//
//  Created by Yuliia Engman on 4/7/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var welcomeImage: UIImageView!
    
    private var fontSizeObservation: NSKeyValueObservation?
    private var iconNameObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFontSizeObservation()
        configureIconNameObservation()
    }
    
    private func configureFontSizeObservation() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            
            guard let newSize = change.newValue else { return }
            //update UI
            let fontSize = CGFloat(newSize)
            self?.welcomeLabel.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    
    private func configureIconNameObservation() {
        iconNameObservation = Settings.shared.observe(\.iconName, options: [.old, .new], changeHandler: { [weak self](settings, change) in
            guard let iconName = change.newValue else { return }
            self?.welcomeImage.image = UIImage(systemName: iconName)
        })
    }

    deinit { // gets called when the object is not longer in memory
        // if you do not want to get updates
        fontSizeObservation?.invalidate()
        iconNameObservation?.invalidate()
    }

}

