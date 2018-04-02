//
//  UITableViewCell+Rx.swift
//  iOS
//
//  Created by Mario Canto on 3/27/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
	
	import UIKit
	import RxSwift
	
	private var tableViewCellPrepareForReuseBag: Int8 = 0
	extension Reactive where Base: UITableViewCell {
		var prepareForReuse: Observable<Void> {
			return Observable.of(sentMessage(#selector(UITableViewCell.prepareForReuse)).map { _ in () }, deallocated).merge()
		}
		
		var disposeBag: DisposeBag {
			MainScheduler.ensureExecutingOnScheduler()
			
			if let bag = objc_getAssociatedObject(base, &tableViewCellPrepareForReuseBag) as? DisposeBag {
				return bag
			}
			
			let bag = DisposeBag()
			objc_setAssociatedObject(base, &tableViewCellPrepareForReuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
			
			_ = sentMessage(#selector(UITableViewCell.prepareForReuse))
				.subscribe(onNext: { [weak base] _ in
					let newBag = DisposeBag()
					objc_setAssociatedObject(base as Any, &tableViewCellPrepareForReuseBag, newBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
				})
			
			return bag
		}
	}
	
	
#endif
