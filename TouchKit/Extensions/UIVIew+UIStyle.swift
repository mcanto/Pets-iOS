//
//  UIVIew+UIStyle.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

extension UIView {
	
	public convenience init< V >( style: UIStyle< V > ) {
		self.init( frame: .zero )
		apply( style )
	}
	
	public func apply< V >( _ style: UIStyle< V > ) {
		guard let view = self as? V else {
			return
		}
		style.apply( to: view )
	}
}
