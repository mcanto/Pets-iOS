//
//  Label.swift
//  TouchKit
//
//  Created by Mario Canto on 3/28/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

open class Label: UILabel {

	override open var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize
		size.height *= 1.5
		return size
	}
}
