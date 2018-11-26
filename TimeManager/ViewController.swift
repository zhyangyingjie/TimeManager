//
//  ViewController.swift
//  TimeManager
//
//  Created by 张英杰 on 2018/11/24.
//  Copyright © 2018年 张英杰. All rights reserved.
//

import UIKit
import BEMAnalogClock

class ViewController: UIViewController ,BEMAnalogClockDelegate{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var clockView : BEMAnalogClockView!
    
    
    var timeHandler = TMTimeHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        clockView.delegate = self
        clockView.realTime = true
        clockView.startRealTime()
        clockView.faceBackgroundColor = UIColor.black
        clockView.faceBackgroundAlpha = 0.8
        createDisplayLink()
        configLabelFont()
    }
    
    func configLabelFont() {
        let originalFontDescriptor = detailLabel.font.fontDescriptor
        
        let fontDescriptorFeatureSettings = [
            [
                kCTFontFeatureTypeIdentifierKey: kNumberSpacingType,
                kCTFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
            ]
        ]
        
        let fontDescriptorAttributes = [kCTFontFeatureSettingsAttribute: fontDescriptorFeatureSettings]
        let fontDescriptor = originalFontDescriptor.addingAttributes(fontDescriptorAttributes as [UIFontDescriptor.AttributeName : Any])
        let font = UIFont(descriptor: fontDescriptor, size: 0)
        
        detailLabel.font = font
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    func createDisplayLink() {
        let displaylink = CADisplayLink(target: self,
                                        selector: #selector(refresh))
        displaylink.preferredFramesPerSecond = 15
        displaylink.add(to: .current,
                        forMode: .defaultRunLoopMode)
    }
    
    @objc func refresh() {
        let currentYear = timeHandler.getCurrentYear()
        let totalInterval = timeHandler.getWholeYearSecond(year: currentYear)
        let passedInterval = timeHandler.getPassedSecondThisYear(year: currentYear)
        titleLabel.text = "\(currentYear) 年已经过去"
        
        let costString = String(format: "%.8f", passedInterval/totalInterval * 100)
        detailLabel.text = "\(costString) %"
    }
}



