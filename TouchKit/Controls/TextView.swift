//
//  TextView.swift
//  TouchKit
//
//  Created by Mario Canto on 3/24/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

@IBDesignable
open class TextView: UITextView {
	
	override open var intrinsicContentSize: CGSize {
		var size = super.contentSize
		size.height = max(size.height + contentInset.top + contentInset.bottom, 44)
		return size
	}
}
