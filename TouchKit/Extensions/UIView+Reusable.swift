//
//  UIView+Reusable.swift
//  Pets
//
//  Created by Mario Canto on 1/31/18.
//  Copyright © 2018 Mario Canto. All rights reserved.
//

import UIKit

extension UIView: Reusable {}

public extension UITableView {
	func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
		guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
											 for: indexPath) as? T else {
												fatalError()
		}
		return cell
	}
	
	func dequeueReusableHeaderFooterView<T>(ofType viewType: T.Type = T.self, at section: Int) -> T where T: UITableViewHeaderFooterView {
		guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseID) as? T else {
			fatalError()
		}
		return view
	}
	
}

extension UICollectionView {
	func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
		guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseID,
											 for: indexPath) as? T else {
												fatalError()
		}
		
		return cell
	}
	
	func dequeueReusableSupplementaryView<T>(ofType supplementaryViewType: T.Type = T.self, supplementaryElementOfKind kind: String, at indexPath: IndexPath) -> T where T: UICollectionReusableView {
		guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: supplementaryViewType.reuseID, for: indexPath) as? T else {
			fatalError()
		}
		return view
	}
}


