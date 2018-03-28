//
//  SignInCoordinator.swift
//  iOS
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import TouchKit

final class SignInCoordinator: RootCoordinator {
	var delegate: CoordinatorDelegate?	
	var childCoordinators: [Coordinator] = []
	var rootViewController: UIViewController {
		return navigationController
	}
	
	private lazy var navigationController: UINavigationController = {
		$0.navigationBar.apply(Theme.Login.navigationBar)		
		return $0
	}(UINavigationController())
	
	func start() {
		let viewController = SignInViewController()
		viewController.delegate = self
		navigationController.viewControllers = [viewController]
		
	}
}

extension SignInCoordinator: ActionDelegate {
	func actionSender(_ sender: Any, didReceiveAction action: DelegatedAction) {
		switch action {
		case SignInViewController.Action.createAccount:
			Logger.log(message: "create account", event: .debug)
			let viewController = JoinViewController()
			navigationController.pushViewController(viewController, animated: true)
		default:
			break
		}
	}
	
	
}
