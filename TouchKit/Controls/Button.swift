//
//  Button.swift
//  TouchKit
//
//  Created by Mario Canto on 3/27/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit


open class Button: UIButton {
	
	public var defaultHeight: CGFloat = 44.0 {
		didSet {
			
		}
	}
	
	override open var bounds: CGRect {
		didSet(oldBounds) {
			if oldBounds.height != bounds.height {
				invalidateIntrinsicContentSize()
			}
		}
	}
	
	override open var frame: CGRect {
		didSet(oldBounds) {
			if oldBounds.height != frame.height {
				invalidateIntrinsicContentSize()
			}
		}
	}
	
	override open var intrinsicContentSize: CGSize {
		let textSize = titleLabel?.intrinsicContentSize ?? CGSize.zero
		return CGSize(width: textSize.width + titleEdgeInsets.left + titleEdgeInsets.right + bounds.height,
					  height: max(textSize.height, defaultHeight) + titleEdgeInsets.top + titleEdgeInsets.bottom)
	}
}
