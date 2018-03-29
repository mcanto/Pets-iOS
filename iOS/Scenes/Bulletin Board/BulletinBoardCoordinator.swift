//
//  BulletinBoardCoordinator.swift
//  iOS
//
//  Created by Mario Canto on 3/28/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import TouchKit

final class BulletinBoardCoordinator: RootCoordinator {
	var delegate: CoordinatorDelegate?
	
	var childCoordinators: [Coordinator] = []
	
	func start() {
		let viewController = BulletinBoardViewController()
		
		navigationController.viewControllers = [viewController]
	}
	
	var rootViewController: UIViewController {
		return navigationController
	}
	
	private lazy var navigationController: UINavigationController = {
		$0.navigationBar.apply(Theme.Default.navigationBar)
		return $0
	}(UINavigationController())
	
}

extension BulletinBoardCoordinator  {
	
}
