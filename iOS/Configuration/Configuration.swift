//
//  Configuration.swift
//  iOS
//
//  Created by Mario Canto on 3/24/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//
import Foundation

struct Configuration {
	
	static let shared = Configuration()
	
	private lazy var mainBundlePath: String = {
		let InfoPlist = (name: "Info", extension: "plist")
		return Bundle.main.path(forResource: InfoPlist.name, ofType: InfoPlist.extension)!
	}()
	
	private lazy var bundledExecutableConfigurationInfo: [AnyHashable: Any] = {
		let info = NSDictionary(contentsOfFile: $0) as! [AnyHashable: Any]
		return info["BundledExecutableConfigurationInfo"] as! [AnyHashable: Any]
	}(mainBundlePath)
	
	
	lazy var apiBasePath: String = {
		$0["APIBasePath"] as! String
	}(bundledExecutableConfigurationInfo)
	
	private init() {}
}
