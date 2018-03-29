//
//  BulletinBoardViewController.swift
//  iOS
//
//  Created by Mario Canto on 3/28/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit
import TouchKit

final class BulletinBoardViewController: UIViewController {

	private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
		$0.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 10)
		$0.minimumLineSpacing = 20
		$0.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
		return $0
	}(UICollectionViewFlowLayout())
	
	private lazy var collectionView: UICollectionView = {
		$0.register(BulletinCollectionCell.self, forCellWithReuseIdentifier: BulletinCollectionCell.reuseId)
		$1.addSubview($0)
		$0.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			$0.leadingAnchor.constraint(equalTo: $1.leadingAnchor),
			$0.trailingAnchor.constraint(equalTo: $1.trailingAnchor),
			$0.topAnchor.constraint(equalTo: $1.topAnchor),
			$0.bottomAnchor.constraint(equalTo: $1.bottomAnchor)
			])
		return $0
	}(UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout), view!)
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension BulletinBoardViewController {
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		collectionViewFlowLayout.estimatedItemSize = CGSize(width: view.bounds.width, height: 10)
	}
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		collectionViewFlowLayout.estimatedItemSize = CGSize(width: view.bounds.width, height: 10)
		collectionViewFlowLayout.invalidateLayout()
	}
}

extension BulletinBoardViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: BulletinCollectionCell = collectionView.dequeueReusableCell(at: indexPath)
		
		return cell
	}
}

extension BulletinBoardViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		
	}
}

private final class BulletinCollectionCell: UICollectionViewCell {
	
	private lazy var width: NSLayoutConstraint = {
		$0.isActive = true
		return $0
	}(contentView.widthAnchor.constraint(equalToConstant: bounds.width))
	
	private lazy var memberImageView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		$0.contentMode = .scaleAspectFill
		$0.clipsToBounds = true
		$0.image = #imageLiteral(resourceName: "kimi").scaled(to: CGSize.init(width: 34, height: 34))
//		$0.fixedContentSize = CGSize(width: 34, height: 34)
		return $0
	}(UIImageView())
	private lazy var usernameLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultHigh, for: .vertical)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		$0.text = "hello"
		return $0
	}(Label())
	private lazy var postImageView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		$0.setContentHuggingPriority(.defaultHigh, for: .vertical)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		$0.clipsToBounds = true
		$0.image = #imageLiteral(resourceName: "kimi")
		$0.contentMode = .scaleAspectFill
		return $0
	}(UIImageView())
	private lazy var commentsLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultLow, for: .horizontal)
		$0.setContentHuggingPriority(.defaultHigh, for: .vertical)
		//			$0.setContentCompressionResistancePriority(, for: .horizontal)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		$0.text = "hello"
		return $0
	}(Label())
	private lazy var dateLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		$0.setContentHuggingPriority(.defaultHigh, for: .vertical)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		$0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		$0.text = "hello"
		return $0
	}(Label())
	
	private lazy var topStackView: UIStackView = {
		$0.axis = .horizontal
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.spacing = 8
		return $0
	}(UIStackView(arrangedSubviews: [ memberImageView, usernameLabel ]))
	
	private lazy var bottomStackView: UIStackView = {
		$0.axis = .horizontal
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.spacing = 8
		return $0
	}(UIStackView(arrangedSubviews: [ commentsLabel, dateLabel ]))
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func commonSetup() {
//		layer.cornerRadius = 3
//		layer.shadowColor = #colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1)
//		layer.shadowOffset = CGSize(width: 0, height: 2)
//		layer.shadowOpacity = 0.5
//		layer.shadowRadius = 2
//		layer.masksToBounds = false
		contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(topStackView)
		contentView.addSubview(postImageView)
		contentView.addSubview(bottomStackView)
		
		NSLayoutConstraint.activate([
			topStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			//				topStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
			topStackView.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.layoutMarginsGuide.trailingAnchor),
			topStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			postImageView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 8),
			postImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			postImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
			postImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			bottomStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
			bottomStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			bottomStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//			bottomStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			contentView.bottomAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 10)
			])
	}

}

extension BulletinCollectionCell {
	override func systemLayoutSizeFitting(_ targetSize: CGSize,
										  withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
										  verticalFittingPriority: UILayoutPriority) -> CGSize {
		width.constant = bounds.size.width
		return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
	}
}
