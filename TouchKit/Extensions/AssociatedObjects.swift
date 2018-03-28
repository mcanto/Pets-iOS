//
//  AssociatedObjects.swift
//  TouchKit
//
//  Created by Mario Canto on 3/24/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import Foundation



public func associatedObject<ValueType: AnyObject>(
	_ base: AnyObject,
	key: UnsafePointer<UInt8>,
	initializer: () -> ValueType)
	-> ValueType {
		if let associated = objc_getAssociatedObject(base, key)
			as? ValueType { return associated }
		let associated = initializer()
		objc_setAssociatedObject(base, key, associated,
								 .OBJC_ASSOCIATION_RETAIN)
		return associated
}
public func associateObject<ValueType: AnyObject>(
	_ base: AnyObject,
	key: UnsafePointer<UInt8>) -> ValueType? {
	return objc_getAssociatedObject(base, key) as? ValueType
}
public func setAssociateObject<ValueType: AnyObject>(
	_ base: AnyObject,
	key: UnsafePointer<UInt8>,
	value: ValueType) {
	objc_setAssociatedObject(base, key, value,
							 .OBJC_ASSOCIATION_RETAIN)
}



