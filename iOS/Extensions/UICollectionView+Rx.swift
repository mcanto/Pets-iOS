//
//  UICollectionView+Rx.swift
//  iOS
//
//  Created by Mario Canto on 3/30/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
	
	import UIKit
	import RxSwift
	
	private var collectionViewCellprepareForReuseBag: Int8 = 0
	extension Reactive where Base: UICollectionViewCell {
		var prepareForReuse: Observable<Void> {
			return Observable.of(sentMessage(#selector(UICollectionViewCell.prepareForReuse)).map { _ in () }, deallocated).merge()
		}
		
		var disposeBag: DisposeBag {
			MainScheduler.ensureExecutingOnScheduler()
			
			if let bag = objc_getAssociatedObject(base, &collectionViewCellprepareForReuseBag) as? DisposeBag {
				return bag
			}
			
			let bag = DisposeBag()
			objc_setAssociatedObject(base, &collectionViewCellprepareForReuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
			
			_ = sentMessage(#selector(UICollectionViewCell.prepareForReuse))
				.subscribe(onNext: { [weak base] _ in
					let newBag = DisposeBag()
					objc_setAssociatedObject(base as Any, &collectionViewCellprepareForReuseBag, newBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
				})
			
			return bag
		}
	}
	
	
#endif
