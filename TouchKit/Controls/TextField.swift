//
//  TextField.swift
//  TouchKit
//
//  Created by Mario Canto on 3/24/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

@IBDesignable
open class TextField: UITextField {
	
	override open var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize
		size.height *= 1.5
		return size
	}
}
