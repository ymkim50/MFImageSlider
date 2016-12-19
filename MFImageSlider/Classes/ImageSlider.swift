//
//  ImageSlider.swift
//  Pods
//
//  Created by Youngmin Kim on 2016. 12. 19..
//
//

import UIKit

public protocol FImageSliderDelegate: class {
	func sliderValueChanged(slider: FImageSlider)		// call when user is swiping slider
	func sliderValueChangeEnded(slider: FImageSlider)	// calls when user touchUpInside or touchUpOutside slider
}


let	handleWidth: CGFloat            = 14.0
let borderWidth: CGFloat            = 2.0
let viewCornerRadius: CGFloat       = 5.0
let animationDuration: TimeInterval = 0.1// speed when slider change position on tap

public class FImageSlider: UIView {
	public enum Orientation {
		case vertical
		case horizontal
	}
	
	public weak var delegate: FImageSliderDelegate? = nil
	
	lazy var imageView: UIImageView = {
		var imageView = UIImageView()
		imageView.backgroundColor = .red
		imageView.frame = self.bounds
		
		imageView.isHidden = true
		
		return imageView
	}()
	
	public var backgroundImage: UIImage?  {
		get {
			return imageView.image
		}
		
		set {
			if let image = newValue {
				imageView.image = image
				imageView.isHidden = false
			} else {
				imageView.image = nil
				imageView.isHidden = true
			}
		}
	}
	
	
	lazy var foregroundView: UIView = {
		var view = UIView()
		return view
	}()
	
	lazy var handleView: UIView = {
		var view = UIView()
		view.layer.cornerRadius = viewCornerRadius
		view.layer.masksToBounds = true
		
		return view
	}()
	
	lazy var label: UILabel = {
        var label           = UILabel()

		switch self.orientation {
		case .vertical:
			label.transform     = CGAffineTransform(rotationAngle: CGFloat(-M_PI / 2.0))
			label.frame         = self.bounds

		case .horizontal:
			label.frame         = self.bounds
		}

        label.textAlignment = .center
        label.font          = UIFont(name: "Helvetica", size: 24)

		return label
	}()
	
	var _value: Float = 0.0
	public var value: Float {
		get {
			return _value
		}
		
		set {
			_value = newValue
			self.setValue(value: _value, animated: false, completion: nil)
		}
	}
	
	var orientation: Orientation = .vertical
	
	public var isCornersHidden: Bool = false {
		didSet {
			if isCornersHidden {
				self.layer.cornerRadius = 0.0
				self.layer.masksToBounds = true
			} else {
				self.layer.cornerRadius = viewCornerRadius
				self.layer.masksToBounds = true
			}
		}
	}
	
	public var isBordersHidden: Bool = false {
		didSet {
			if isBordersHidden {
				self.layer.borderWidth = 0.0
			} else {
				self.layer.borderWidth = borderWidth
			}
		}
	}
	
	public var isHandleHidden: Bool = false {
		didSet {
			if isHandleHidden {
				handleView.isHidden = true
				handleView.removeFromSuperview()
			} else {
				insertSubview(handleView, aboveSubview: label)
				handleView.isHidden = false
			}
		}
	}
	
	public var foregroundColor: UIColor? {
		get {
			return foregroundView.backgroundColor
		}
		
		set {
			foregroundView.backgroundColor = newValue
		}
	}
	
	public var handleColor: UIColor? {
		get {
			return handleView.backgroundColor
		}
		
		set {
			handleView.backgroundColor = newValue
		}
	}
	
	public var borderColor: UIColor? {
		get {
			if let cgColor = self.layer.borderColor {
				return UIColor(cgColor: cgColor)
			} else {
				return nil
			}
		}
		
		set {
			return self.layer.borderColor = newValue?.cgColor
		}
	}
	
	public var text: String? {
		get {
			return self.label.text
		}
		
		set {
			self.label.text = newValue
		}
	}
	
	public var font: UIFont! {
		get {
			return self.label.font
		}
		
		set {
			self.label.font = newValue
		}
	}
	
	public var textColor: UIColor! {
		get {
			return self.label.textColor
		}
		
		set {
			self.label.textColor = newValue
		}
	}
	
	public init(frame: CGRect, orientation: Orientation) {
		super.init(frame: frame)
		
		self.orientation = orientation
		initSlider()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		if self.frame.width > self.frame.height {
			orientation = .horizontal
		} else {
			orientation = .vertical
		}
		
		initSlider()
	}
}

extension FImageSlider {
	func initSlider() {
		addSubview(imageView)
		addSubview(foregroundView)
		addSubview(label)
		addSubview(handleView)
		
		self.layer.cornerRadius = viewCornerRadius
		self.layer.masksToBounds = true
		self.layer.borderWidth = borderWidth
		
		// set default value for slider. Value should be between 0 and 1
		self.setValue(value: 0.0, animated: false, completion: nil)
	}
	
	func setValue(value: Float, animated: Bool, completion: ((Bool) -> Void)? = nil) {
		assert(value >= 0.0 && value <= 1.0, "Value must between 0 and 1")
		
		let calcValue = max(0, min(value, 1))

		var point: CGPoint = .zero
		switch orientation {
		case .vertical:
			point = CGPoint(x: 0, y: CGFloat(1 - calcValue) * self.frame.height)
			
		case .horizontal:
			point = CGPoint(x: CGFloat(calcValue) * self.frame.width, y: 0)
		}
		
		if animated {
			UIView.animate(withDuration: animationDuration, animations: { 
				self.changeStartForegroundView(withPoint: point)
			}, completion: { (completed) in
				if completed {
					completion?(completed)
				}
			})
		} else {
			changeStartForegroundView(withPoint: point)
		}
	}
}

//	MARK:	- Change slider forground with point
extension FImageSlider {
	func changeStartForegroundView(withPoint point: CGPoint) {
		var calcPoint = point
		switch orientation {
		case .vertical:
			calcPoint.y = max(0, min(calcPoint.y, self.frame.height))
			
			self._value = Float(1.0 - (calcPoint.y / self.frame.height))
			self.foregroundView.frame = CGRect(x: 0.0, y: self.frame.height, width: self.frame.width, height: calcPoint.y - self.frame.height)
			
			if !isHandleHidden {
				if foregroundView.frame.origin.y <= 0 {
					handleView.frame = CGRect(x: borderWidth,
					                          y: 0.0,
					                          width: self.frame.width - borderWidth * 2,
					                          height: handleWidth)
				} else if foregroundView.frame.origin.y >= self.frame.height {
					handleView.frame = CGRect(x: borderWidth,
					                          y: self.frame.height - handleWidth,
					                          width: self.frame.width - borderWidth * 2,
					                          height: handleWidth)
				} else {
					handleView.frame = CGRect(x: borderWidth,
					                          y: foregroundView.frame.origin.y - handleWidth / 2,
					                          width: self.frame.width - borderWidth * 2,
					                          height: handleWidth)
				}
			}
			
		case .horizontal:
			
			calcPoint.x = max(0, min(calcPoint.x, self.frame.width))
			
			self._value = Float(calcPoint.x / self.frame.width)
			self.foregroundView.frame = CGRect(x: 0, y: 0, width: calcPoint.x, height: self.frame.height)
			
			if !isHandleHidden {
				if foregroundView.frame.width <= 0 {
					handleView.frame = CGRect(x: 0,
					                          y: borderWidth,
					                          width: handleWidth,
					                          height: foregroundView.frame.height - borderWidth)
					self.delegate?.sliderValueChanged(slider: self)	// or use sliderValueChangeEnded method
				} else if foregroundView.frame.width >= self.frame.width {
					handleView.frame = CGRect(x: foregroundView.frame.width - handleWidth,
					                          y: borderWidth,
					                          width: handleWidth,
					                          height: foregroundView.frame.height - borderWidth * 2)
					self.delegate?.sliderValueChanged(slider: self)	// or use sliderValueChangeEnded method
				} else {
					handleView.frame = CGRect(x: foregroundView.frame.width - handleWidth / 2,
					                          y: borderWidth,
					                          width: handleWidth,
					                          height: foregroundView.frame.height - borderWidth * 2)
				}
			}
		}
	}
}

//	MARK:	- Touch events
extension FImageSlider {
	public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else {
			return
		}

		let point = touch.location(in: self)
		
		switch orientation {
		case .vertical:
			if !(point.y < 0) && !(point.y > self.frame.height) {
				changeStartForegroundView(withPoint: point)
			}
			
		case .horizontal:
			if !(point.x < 0) && !(point.x > self.frame.width) {
				changeStartForegroundView(withPoint: point)
			}
		}
		
		if point.x > 0 && point.x <= self.frame.width - handleWidth {
			delegate?.sliderValueChanged(slider: self)
		}
	}
	
	public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else {
			return
		}
		
		let point = touch.location(in: self)
		
		UIView.animate(withDuration: animationDuration, animations: { 
			self.changeStartForegroundView(withPoint: point)
		}) { (completed) in
			self.delegate?.sliderValueChangeEnded(slider: self)
		}
	}
}
