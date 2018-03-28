//
//  JoinViewController.swift
//  iOS
//
//  Created by Mario Canto on 3/27/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit
import TouchKit
import RxSwift
import RxCocoa

final class JoinViewController: UIViewController {
	
	
	private let disposeBag: DisposeBag = DisposeBag()
	
	private let subjects: [JoinElement: PublishSubject<String>] = [
		.username: PublishSubject<String>(),
		.password: PublishSubject<String>(),
		.passwordConfirm: PublishSubject<String>(),
		.email: PublishSubject<String>(),
		.mobilePhone: PublishSubject<String>()
	]
	
	private let elements: [JoinElement] = [
		.username, .password, .passwordConfirm, .email, .mobilePhone
	]
	private lazy var tableView: UITableView = {
		$2.view.addSubview($0)
		$0.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			$0.leadingAnchor.constraint(equalTo: $2.view.leadingAnchor),
			$0.trailingAnchor.constraint(equalTo: $2.view.trailingAnchor),
			$0.topAnchor.constraint(equalTo: $2.view.topAnchor),
			$0.bottomAnchor.constraint(equalTo: $2.view.bottomAnchor)
			])
		$0.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.reuseID)
		$0.tableFooterView = $1
		return $0
	}(UITableView.init(frame: CGRect.zero, style: .plain), tableFooterView, self)
	
	
	private lazy var createAccountButton: UIButton = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.apply(Theme.Default.button)
		return $0
	}(Button(type: .system))
	
	private lazy var tableFooterView: UIView = {
		let stackView = UIStackView(arrangedSubviews: [$0])
		stackView.axis = .vertical
		stackView.distribution = .fill
		var frame = stackView.frame
		frame.size = stackView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
		stackView.frame = frame
		return stackView
	}(createAccountButton)
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension JoinViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		
		func validatePassword(password: String, confirmation: String) -> Bool {
			guard !password.isEmpty else {
				return false
			}
			guard !confirmation.isEmpty else {
				return false
			}
			
			return password == confirmation
		}
		
		func validateUsername(_ username: String) -> Bool {
			guard !username.isEmpty else {
				return false
			}
			
			return username.count > 3
		}
		
		func validateEmail(_ email: String) -> Bool {
			guard !email.isEmpty else {
				return false
			}
			
			return email.count > 3
		}
		
		func validateMobilePhone(_ mobilePhone: String) -> Bool {
			guard !mobilePhone.isEmpty else {
				return false
			}
			
			return mobilePhone.count > 3
		}
		
		let passwordObservable = subjects[.password]!.asObservable().share(replay: 1, scope: .whileConnected)
		let confirmationObservable = subjects[.passwordConfirm]!.asObservable().share(replay: 1, scope: .whileConnected)
		let usernameObservable = subjects[.username]!.asObservable().share(replay: 1, scope: .whileConnected)
		let emailObservable = subjects[.email]!.asObservable().share(replay: 1, scope: .whileConnected)
		let mobilePhoneObservable = subjects[.mobilePhone]!.asObservable().share(replay: 1, scope: .whileConnected)
		
		let passwordValid = Observable.combineLatest(passwordObservable,
													 confirmationObservable,
													 resultSelector: validatePassword)
		let usernameValid = usernameObservable.map(validateUsername)
		let emailValid = emailObservable.map(validateEmail)
		let mobilePhoneValid = mobilePhoneObservable.map(validateMobilePhone)
		
		func allFieldsValidSelector(passwordValid: Bool, usernameValid: Bool, emailValid: Bool, mobilePhoneValid: Bool) -> Bool {
			return passwordValid && usernameValid && emailValid && mobilePhoneValid
		}
		
		let allFieldsValid = Observable.combineLatest(passwordValid,
													  usernameValid,
													  emailValid,
													  mobilePhoneValid, resultSelector: allFieldsValidSelector)
		allFieldsValid
			.debug()
			.bind(to: createAccountButton.rx.isEnabled)
			.disposed(by: disposeBag)
		
	}
	
}

extension JoinViewController {
	private enum JoinElement: CustomStringConvertible, Hashable {
		case username
		case password
		case passwordConfirm
		case email
		case mobilePhone
		
		var description: String {
			switch self {
			case .username: return NSLocalizedString("Username", comment: "")
			case .password: return NSLocalizedString("Password", comment: "")
			case .passwordConfirm: return NSLocalizedString("Password confirmation", comment: "")
			case .email: return NSLocalizedString("Email", comment: "")
			case .mobilePhone: return NSLocalizedString("Mobile phone", comment: "")
			}
		}
		
		var textFieldPlaceholder: String {
			switch self {
			case .username: return NSLocalizedString("Mandatory", comment: "")
			case .password: return NSLocalizedString("Mandatory", comment: "")
			case .passwordConfirm: return NSLocalizedString("Mandatory", comment: "")
			case .email: return NSLocalizedString("Mandatory", comment: "")
			case .mobilePhone: return NSLocalizedString("Optional", comment: "")
			}
		}
		
		var textFieldStyle: UIStyle<UITextField> {
			switch self {
			case .username:
				return Theme.Default.textField
			case .password:
				return Theme.Default.textField
			case .passwordConfirm:
				return Theme.Default.textField
			case .email:
				return Theme.Default.textField
			case .mobilePhone:
				return Theme.Default.textField
			}
		}
	}
}

extension JoinViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return elements.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: TextFieldCell = tableView.dequeueReusableCell(at: indexPath)
		cell.titleLabel.text = elements[indexPath.row].description
		cell.textField.placeholder = elements[indexPath.row].textFieldPlaceholder
		cell.titleLabel.apply(Theme.Login.textFieldTitle)
		cell.textField.apply(elements[indexPath.row].textFieldStyle)
		cell.textField.rx.text.orEmpty
			.bind(to: subjects[elements[indexPath.row]]!)
			.disposed(by: cell.rx.disposeBag)
		
		return cell
	}
}
