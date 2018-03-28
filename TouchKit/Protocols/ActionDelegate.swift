//
//  ActionDelegator.swift
//  Pets
//
//  Created by Mario Canto on 2/14/18.
//  Copyright © 2018 Mario Canto. All rights reserved.
//

// 
public protocol DelegatedAction {}

public protocol ActionDelegate: class {
	func actionSender(_ sender: Any, didReceiveAction action: DelegatedAction)
}
