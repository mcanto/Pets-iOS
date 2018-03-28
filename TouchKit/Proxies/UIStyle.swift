//
//  UIStyle.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

public struct UIStyle< V: UIView > {
	private let style: ( V ) -> Void
	
	public init(_ style: @escaping ( V ) -> Void) {
		self.style = style
	}
	
	public func apply( to view: V ) {
		style( view )
	}
}
