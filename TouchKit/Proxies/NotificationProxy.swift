//
//  NotificationProxy.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import Foundation

final class NotificationProxy: UIView {
	
	weak var objectProtocol: NSObjectProtocol!
	
	func addObserverForName(_ name: NSNotification.Name?, object: AnyObject?, queue: OperationQueue?, usingBlock: @escaping (Notification) -> Void) {
		// Register the specified object and notification with NSNotificationCenter
		self.objectProtocol = NotificationCenter.default.addObserver(forName: name.map({ $0 }),
																	 object: object, queue: queue, using: usingBlock)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self.objectProtocol)
	}
}
