//
//  UITextView+Placeholder.swift
//  TouchKit
//
//  Created by Mario Canto on 3/24/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import Foundation

private var _placeholderLabelKey: UInt8 = 0

@IBDesignable
public extension UITextView {

	@IBInspectable
	var placeholder: String? {
		get {
			return self.placeholderLabel.text
		}
		set {
			self.placeholderLabel.text = newValue
			self.placeholderLabel.sizeToFit()
		}
	}
	
	private func initializePlaceholderLabel() -> UILabel {
		let placeholderLabel = UILabel()
		placeholderLabel.frame.origin.x = textContainerInset.top / 2.0
		placeholderLabel.frame.origin.y = textContainerInset.top
		placeholderLabel.frame.size.width = self.bounds.size.width - (textContainerInset.left + textContainerInset.right)
		placeholderLabel.frame.size.height = 0.0
		placeholderLabel.font = self.font
		placeholderLabel.sizeToFit()
		placeholderLabel.textColor = #colorLiteral(red: 0.7802323699, green: 0.7799953222, blue: 0.8047742248, alpha: 1)
		
		placeholderLabel.isHidden = !text.isEmpty
		
		addSubview(placeholderLabel)
		
		let notificationProxy = NotificationProxy()
		
		func handleUITextViewTextDidChangeNotification(_ note: Notification) {
			// Respond to Text View text changes
			placeholderLabel.isHidden = self.hasText
		}
		
		notificationProxy.addObserverForName(Notification.Name.UITextViewTextDidChange,
											 object: self, queue: nil, usingBlock: handleUITextViewTextDidChangeNotification)
		addSubview(notificationProxy)
		
		return placeholderLabel
	}
	
	private var placeholderLabel: UILabel {
		get {
			return associatedObject(self, key: &_placeholderLabelKey, initializer: initializePlaceholderLabel)
		}
		set {
			
		}
	}
	
}


