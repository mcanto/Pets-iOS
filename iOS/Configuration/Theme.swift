//
//  StyleSheet.swift
//  iOS
//
//  Created by Mario Canto on 3/26/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import TouchKit

enum Theme {
	
	enum ViewController {
		static var view: UIStyle<UIView> = UIStyle<UIView> {
			$0.tintColor = #colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1)
			$0.backgroundColor = #colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1)
		}
	}
	
	enum Default {
		static var textFieldTitle: UIStyle<UILabel> = UIStyle<UILabel> {
			$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
		}
		
		static var textField: UIStyle<UITextField> = UIStyle<UITextField> {
			$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
			$0.spellCheckingType = .no
			$0.autocorrectionType = .no
			$0.textColor = #colorLiteral(red: 0.3333333333, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
			$0.tintColor = #colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1)
		}
	}
	
	enum Login {
		
		static var navigationBar: UIStyle<UINavigationBar> = UIStyle<UINavigationBar> {
			$0.barTintColor = #colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1)
			$0.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			$0.barStyle = .blackOpaque
		}
		
		static var textFieldTitle: UIStyle<UILabel> = UIStyle<UILabel> {
			$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
		}
		
		static var usernameTextField: UIStyle<UITextField> = UIStyle<UITextField> {
			$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
			$0.spellCheckingType = .no
			$0.autocorrectionType = .no
			$0.textColor = #colorLiteral(red: 0.3333333333, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
			$0.tintColor = #colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1)
		}
		
		static var passwordTextField: UIStyle<UITextField> = UIStyle<UITextField> {
			$0.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
			$0.spellCheckingType = .no
			$0.autocorrectionType = .no
			$0.isSecureTextEntry = true
			$0.textColor = #colorLiteral(red: 0.3333333333, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
			$0.tintColor = #colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1)
		}
		
		static var logInButton: UIStyle<UIButton> = UIStyle<UIButton> {
			$0.setTitle(NSLocalizedString("Log In", comment: ""), for: UIControlState.normal)
			$0.setTitleColor(#colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1), for: UIControlState.normal)
			$0.setTitleColor(#colorLiteral(red: 0.937036097, green: 0.9411780238, blue: 0.945192039, alpha: 1), for: UIControlState.disabled)
			$0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
		}
		
		static var forgotPasswordButton: UIStyle<UIButton> = UIStyle<UIButton> {
			$0.setTitle(NSLocalizedString("Forgot password", comment: ""), for: UIControlState.normal)
			$0.setTitleColor(#colorLiteral(red: 0.8230475783, green: 0.8349480033, blue: 0.8598034978, alpha: 1), for: UIControlState.normal)
			$0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
		}
		
		static var createAccountButton: UIStyle<UIButton> = UIStyle<UIButton> {
			$0.setTitle(NSLocalizedString("Join to Pets", comment: ""), for: UIControlState.normal)
			$0.setTitleColor(#colorLiteral(red: 0.9986756444, green: 0.2878709137, blue: 0.4008231759, alpha: 1), for: UIControlState.normal)
			$0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
		}
	}
	
	
}
