//
//  Coordinator.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

public protocol CoordinatorFlow {}

public protocol CoordinatorDelegate: AnyObject {
	func performFlow(_ flow: CoordinatorFlow, sender: RootCoordinator)
}

extension CoordinatorDelegate where Self: Coordinator {}

public protocol Coordinator: AnyObject {
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

public protocol RootViewControllerProvider: AnyObject {
	var rootViewController: UIViewController { get }
}

public typealias RootCoordinator = Coordinator & RootViewControllerProvider
