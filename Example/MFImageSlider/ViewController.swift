//
//  ViewController.swift
//  MFImageSlider
//
//  Created by Youngmin Kim on 12/19/2016.
//  Copyright (c) 2016 Youngmin Kim. All rights reserved.
//

import UIKit
import MFImageSlider

class ViewController: UIViewController, FImageSliderDelegate {

	lazy var horSlider: FImageSlider = {
		var slider = FImageSlider(frame: CGRect(x: 20, y: 40, width: 280, height: 70), orientation: .horizontal)
		
		slider.delegate        = self
        slider.backgroundColor = UIColor(red: 27.0 / 255.0, green: 28.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0)
        slider.foregroundColor = UIColor(red: 0.0, green: 106.0 / 255.0, blue: 95.0 / 255.0, alpha: 0.4)
        slider.handleColor     = UIColor(red: 0.0, green: 205.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
        slider.borderColor     = UIColor(red: 0.0, green: 205.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
        slider.text            = "Horizontal slider"
		// default font is Helvetica, size 24, so set font only if you need to change it
		slider.font			   = UIFont(name: "Helvetica", size: 25)
		
		slider.backgroundImage = #imageLiteral(resourceName: "background")
		
		return slider
	}()
	
	lazy var verSlider: FImageSlider = {
		var slider = FImageSlider(frame: CGRect(x: 150, y: 200, width: 80, height: 300), orientation: .vertical)
		
		slider.delegate        = self
		
		slider.backgroundColor = UIColor(red: 37.0 / 255.0, green: 46.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
		slider.foregroundColor = UIColor(red: 32.0, green: 86.0 / 255.0, blue: 0.0, alpha: 1.0)
		slider.handleColor     = UIColor(red: 128.0, green: 209.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
		slider.borderColor     = UIColor(red: 128.0, green: 209.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
		
		slider.isHandleHidden = true
		slider.isCornersHidden = true
		slider.isBordersHidden = true
		
		
		slider.text            = "Vertical slider"
		// default font is Helvetica, size 24, so set font only if you need to change it
		slider.font			   = UIFont(name: "Helvetica", size: 25)
		slider.textColor = UIColor(red: 128.0 / 255.0, green: 209 / 255, blue: 79.0 / 255.0, alpha: 1.0)

		return slider
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		view.addSubview(horSlider)
		view.addSubview(verSlider)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func sliderValueChanged(slider: FImageSlider) {
		print("Value changed: \(slider.value)")
	}
	
	func sliderValueChangeEnded(slider: FImageSlider) {
		print("Touch ended: \(slider.value)")
	}
	
}

