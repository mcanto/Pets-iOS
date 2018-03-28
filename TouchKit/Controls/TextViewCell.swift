//
//  TextViewCell.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

final class TextViewCell: UITableViewCell {
	
	var textViewTextDidBeginEditingBlock: ( (String) -> Void )? = nil
	var textViewTextDidChangeBlock: ( (String) -> Void )? = nil
	var textViewTextDidEndEditingBlock: ( (String) -> Void )? = nil
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonSetup()
		layoutChildViews()
	}
	
	// Maybe it will support storyboard in a future
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonSetup()
		layoutChildViews()
	}
	
	private(set) lazy var titleLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
		return $0
	}(UILabel())
	
	private(set) lazy var textView: UITextView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultLow, for: .horizontal)
		$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
		$0.spellCheckingType = .no
		$0.autocorrectionType = .no
		return $0
	}(TextView())
	
	private let interItemSpacing: CGFloat = 8
	
	private func layoutChildViews() {
		//		contentView.addSubview(titleLabel)
		contentView.addSubview(textView)
		let layoutMarginsGuide = contentView.layoutMarginsGuide
		NSLayoutConstraint.activate([
			textView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			textView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
			textView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
			textView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
			])
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		unsubscribeToUITextViewTextDidBeginEditingNotifications()
		unsubscribeToUITextViewTextDidChangeNotifications()
		unsubscribeToUITextFieldViewDidEndEditingNotifications()
		subscribeToUITextViewTextDidBeginEditingNotifications()
		subscribeToUITextViewTextDidChangeNotifications()
		subscribeToUITextViewTextDidEndEditingNotifications()
	}
	
	private func commonSetup() {
		selectionStyle = .none
		subscribeToUITextViewTextDidBeginEditingNotifications()
		subscribeToUITextViewTextDidChangeNotifications()
		subscribeToUITextViewTextDidEndEditingNotifications()
	}
	
	// MARK:- UITextFieldTextDidBeginEditing
	private func subscribeToUITextViewTextDidBeginEditingNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(TextViewCell.textViewTextDidBeginEditing(_:)),
											   name: .UITextViewTextDidBeginEditing, object: textView)
	}
	private func unsubscribeToUITextViewTextDidBeginEditingNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UITextViewTextDidBeginEditing, object: textView)
	}
	// MARK:- UITextFieldTextDidChange
	private func subscribeToUITextViewTextDidChangeNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(TextViewCell.textViewTextDidChange(_:)),
											   name: .UITextViewTextDidChange, object: textView)
	}
	private func unsubscribeToUITextViewTextDidChangeNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UITextViewTextDidChange, object: textView)
	}
	// MARK:- UITextFieldTextDidEndEditing
	private func subscribeToUITextViewTextDidEndEditingNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(TextViewCell.textViewTextDidEndEditing(_:)),
											   name: .UITextViewTextDidEndEditing, object: textView)
	}
	private func unsubscribeToUITextFieldViewDidEndEditingNotifications() {
		NotificationCenter.default.removeObserver(self, name: .UITextViewTextDidEndEditing, object: textView)
	}
	
	
	@objc
	private func textViewTextDidBeginEditing(_ notification: Notification) {
		Logger.log(message: textView.text, event: .debug)
		textViewTextDidBeginEditingBlock?(textView.text!)
	}
	@objc
	private func textViewTextDidChange(_ notification: Notification) {
		Logger.log(message: textView.text, event: .debug)
		textView.invalidateIntrinsicContentSize()
		textViewTextDidChangeBlock?(textView.text!)
		
	}
	@objc
	private func textViewTextDidEndEditing(_ notification: Notification) {
		Logger.log(message: textView.text, event: .debug)
		textViewTextDidEndEditingBlock?(textView.text!)
	}
	
}
