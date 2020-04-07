//
//  SettingsViewController.swift
//  KVO-iOS-Project
//
//  Created by Yuliia Engman on 4/7/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fontsizeLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    // creating observer
    private var fontSizeObservation: NSKeyValueObservation?
    
    // data for the pickerview
    private let iconNames = ["sun.haze.fill", "moon", "globe", "icloud"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureFontSizeObservstion()
    }
    
    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func configureFontSizeObservstion() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self](settings, change) in
            guard let newSize = change.newValue else { return }
            self?.fontsizeLabel.text = newSize.description
        })
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let newSize = Int(sender.value) // sender.value itselfFloat - we want to change from Float to the integer
        
         //after setting the font size in the Settings class the Welcome VC will be updated via KVO
        Settings.shared.fontSize = newSize
    }

}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iconNames.count
    }
    
    

}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return iconNames[row] // gives titles to the rows
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let iconName = iconNames[row]
        //after setting the icon name in the Settings class the Welcome VC will be updated via KVO
        Settings.shared.iconName = iconName
        
    }
}
