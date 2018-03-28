//
//  Coordinator.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

public protocol CoordinatorFlow {}

public protocol CoordinatorDelegate where Self: Coordinator {
	func performFlow(_ flow: CoordinatorFlow, sender: Coordinator)
}

public protocol Coordinator: class {
	var delegate: CoordinatorDelegate? { get set }
	var childCoordinators: [Coordinator] { get set }
	func start()
}


extension Coordinator {
	public func addChildCoordinator(_ childCoordinator: Coordinator) {
		childCoordinators.append(childCoordinator)
	}
	
	public func removeChildCoordinator(_ childCoordinator: Coordinator) {
		childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
	}
}

public protocol RootViewControllerProvider {
	var rootViewController: UIViewController { get }
}

public typealias RootCoordinator = Coordinator & RootViewControllerProvider
