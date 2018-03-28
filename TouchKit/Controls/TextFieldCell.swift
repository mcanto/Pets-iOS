//
//  UITableViewCellTextField.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

public final class TextFieldCell: UITableViewCell {
	
	public var textFieldTextDidBeginEditingBlock: ( (String) -> Void )? = nil
	public var textFieldTextDidChangeBlock: ( (String) -> Void )? = nil
	public var textFieldTextDidEndEditingBlock: ( (String) -> Void )? = nil
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonSetup()
		layoutChildViews()
	}
	
	// Maybe it will support storyboard in a future
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonSetup()
		layoutChildViews()
	}
	
	public private(set) lazy var titleLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		return $0
	}(UILabel())
	
	public private(set) lazy var textField: UITextField = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultLow, for: .horizontal)
		return $0
	}(TextField())
	
	private let interItemSpacing: CGFloat = 8
	
	private func layoutChildViews() {
		
		
		contentView.addSubview(titleLabel)
		contentView.addSubview(textField)
		let layoutMarginsGuide = contentView.layoutMarginsGuide
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: interItemSpacing),
			textField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
			textField.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
			textField.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
			])
	}
	
	override public func prepareForReuse() {
		super.prepareForReuse()
		unsubscribeToUITextFieldTextDidBeginEditingNotifications()
		unsubscribeToUITextFieldTextDidChangeNotifications()
		unsubscribeToUITextFieldTextDidEndEditingNotifications()
		subscribeToUITextFieldTextDidBeginEditingNotifications()
		subscribeToUITextFieldTextDidChangeNotifications()
		subscribeToUITextFieldTextDidEndEditingNotifications()
	}
	
	private func commonSetup() {
		selectionStyle = .none
		subscribeToUITextFieldTextDidBeginEditingNotifications()
		subscribeToUITextFieldTextDidChangeNotifications()
		subscribeToUITextFieldTextDidEndEditingNotifications()
	}
	
	
	// MARK:- UITextFieldTextDidBeginEditing
	private func subscribeToUITextFieldTextDidBeginEditingNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(TextFieldCell.textFieldTextDidBeginEditing(_:)),
											   name: .UITextFieldTextDidBeginEditing, object: textField)
	}
	private func unsubscribeToUITextFieldTextDidBeginEditingNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidBeginEditing, object: textField)
	}
	// MARK:- UITextFieldTextDidChange
	private func subscribeToUITextFieldTextDidChangeNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(TextFieldCell.textFieldTextDidChange(_:)),
											   name: .UITextFieldTextDidChange, object: textField)
	}
	private func unsubscribeToUITextFieldTextDidChangeNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidChange, object: textField)
	}
	// MARK:- UITextFieldTextDidEndEditing
	private func subscribeToUITextFieldTextDidEndEditingNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(TextFieldCell.textFieldTextDidEndEditing(_:)),
											   name: .UITextFieldTextDidEndEditing, object: textField)
	}
	private func unsubscribeToUITextFieldTextDidEndEditingNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidEndEditing, object: textField)
	}
	
	
	@objc
	private func textFieldTextDidBeginEditing(_ notification: Notification) {
//		Logger.log(message: textField.text, event: .debug)
		textFieldTextDidBeginEditingBlock?(textField.text!)
	}
	@objc
	private func textFieldTextDidChange(_ notification: Notification) {
//		Logger.log(message: textField.text, event: .debug)
		textFieldTextDidChangeBlock?(textField.text!)
	}
	@objc
	private func textFieldTextDidEndEditing(_ notification: Notification) {
//		Logger.log(message: textField.text, event: .debug)
		textFieldTextDidEndEditingBlock?(textField.text!)
	}
}
