//
//  Reusable.swift
//  Pets
//
//  Created by Mario Canto on 1/31/18.
//  Copyright © 2018 Mario Canto. All rights reserved.
//

public protocol Reusable {
	static var reuseID: String { get }
}

extension Reusable {
	public static var reuseID: String {
		return String(describing: self)
	}
}
