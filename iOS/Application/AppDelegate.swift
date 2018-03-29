//
//  AppDelegate.swift
//  Pets
//
//  Created by Mario Canto on 3/24/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit
import TouchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RootCoordinator {
	weak var delegate: CoordinatorDelegate?
	var childCoordinators: [Coordinator] = []
	
	lazy var rootViewController: UIViewController = {
		$0.view.apply(Theme.ViewController.view)
		return $0
	}(UIViewController())
	
	lazy var window: UIWindow? = {
		$0.rootViewController = $1
		$0.apply(Theme.ViewController.view)
		return $0
	}(UIWindow(frame: UIScreen.main.bounds), rootViewController)
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		
		start()
		window?.makeKeyAndVisible()

		return true
	}
}

extension AppDelegate {
	func start() {
		let logInCoordinator = SignInCoordinator()
		logInCoordinator.delegate = self
		logInCoordinator.start()
		logInCoordinator.rootViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		rootViewController.add(asChildViewController: logInCoordinator.rootViewController)
		addChildCoordinator(logInCoordinator)
	}
}

extension AppDelegate: CoordinatorDelegate {
	func performFlow(_ flow: CoordinatorFlow, sender: RootCoordinator) {
		switch flow {
		case SignInCoordinator.Flow.toBulletinBoard:
			let bulletinBoardCoordinator = BulletinBoardCoordinator()
			bulletinBoardCoordinator.delegate = self
			bulletinBoardCoordinator.start()
			bulletinBoardCoordinator.rootViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			rootViewController.remove(asChildViewController: sender.rootViewController)
			rootViewController.add(asChildViewController: bulletinBoardCoordinator.rootViewController)
			addChildCoordinator(bulletinBoardCoordinator)
		default:
			break
		}
	}
	
	
}
