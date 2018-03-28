//
//  StyleSheet.swift
//  TouchKit
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

public enum StyleSheet {

	static var textFieldTitle: UIStyle< UILabel > = UIStyle< UILabel > {
		$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
	}
	
	static var textField: UIStyle< UITextField > = UIStyle< UITextField > {
		$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
	}
}



