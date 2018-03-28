//
//  UIViewController+ContainerViewController.swift
//  Pets
//
//  Created by Mario Canto on 1/31/18.
//  Copyright © 2018 Mario Canto. All rights reserved.
//

import UIKit

extension UIViewController {
	public func add(asChildViewController viewController: UIViewController) {
		addChildViewController(viewController)
		view.addSubview(viewController.view)
		viewController.didMove(toParentViewController: self)
	}
	
	public func remove(asChildViewController viewController: UIViewController) {
		guard viewController.parent != nil else {
			return
		}
		viewController.willMove(toParentViewController: nil)
		viewController.view.removeFromSuperview()
		viewController.removeFromParentViewController()
	}
}
