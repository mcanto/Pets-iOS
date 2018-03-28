//
//  SignInViewController.swift
//  iOS
//
//  Created by Mario Canto on 3/24/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit
import TouchKit
import RxSwift
import RxCocoa

final class SignInViewController: UIViewController {
	
	var delegate: ActionDelegate?
	
	enum Action: DelegatedAction {
		case createAccount
	}
	
	private let disposeBag: DisposeBag = DisposeBag()
	private let usernameSubject: PublishSubject<String> = PublishSubject<String>()
	private let passwordSubject: PublishSubject<String> = PublishSubject<String>()
	
	private let elements: [LoginElement] = [
		.username, .password
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
	
	
	private lazy var loginButton: UIButton = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.apply(Theme.Login.logInButton)
		return $0
	}(Button(type: .system))
	
	private lazy var forgotPasswordButton: UIButton = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.apply(Theme.Login.forgotPasswordButton)
		return $0
	}(Button(type: .system))
	
	private lazy var createAccountButton: UIButton = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.apply(Theme.Login.createAccountButton)
		return $0
	}(Button(type: .system))
	
	private lazy var tableFooterView: UIView = {
		let stackView = UIStackView(arrangedSubviews: [$0, $1, $2])
		stackView.axis = .vertical
		stackView.distribution = .fill
		var frame = stackView.frame
		frame.size = stackView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
		stackView.frame = frame
		return stackView
	}(loginButton, forgotPasswordButton, createAccountButton)
	
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

extension SignInViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		
		func usernameAndPasswordSelector(username: String, password: String) -> (username: String, password: String) {
			return (username, password)
		}
		
		func validateUsernameAndPassword(_ username: String, password: String) -> Bool {
			return !username.isEmpty && !password.isEmpty
		}
		
		let usernameObservable = usernameSubject.asObservable().share(replay: 1, scope: .whileConnected)
		let passwordObservable = passwordSubject.asObservable().share(replay: 1, scope: .whileConnected)
		
//		let credentials = Observable.combineLatest(usernameObservable, passwordObservable, resultSelector: usernameAndPasswordSelector)
		let credentials = Observable.combineLatest(usernameObservable, passwordObservable)
		let validUsernameAndPassword = Observable.combineLatest(usernameObservable, passwordObservable, resultSelector: validateUsernameAndPassword)
		
		
		validUsernameAndPassword
			.bind(to: loginButton.rx.isEnabled)
			.disposed(by: disposeBag)
		
		
		loginButton.rx.tap
			.debounce(0.3, scheduler: MainScheduler.instance)
			.withLatestFrom(credentials)
			.flatMapLatest(signIn)
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: signedIn)
			.disposed(by: disposeBag)
		forgotPasswordButton.rx.tap
			.subscribe(onNext: forgotPassword)
			.disposed(by: disposeBag)
		createAccountButton.rx.tap
			.subscribe(onNext: createAccount)
			.disposed(by: disposeBag)
		
	}
	
}

extension SignInViewController {
	private enum LoginElement: CustomStringConvertible {
		case username
		case password
		
		var description: String {
			switch self {
			case .username: return NSLocalizedString("Username", comment: "")
			case .password: return NSLocalizedString("Password", comment: "")
			}
		}
	}
}

extension SignInViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return elements.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: TextFieldCell = tableView.dequeueReusableCell(at: indexPath)
		cell.titleLabel.text = elements[indexPath.row].description
		cell.textField.placeholder = elements[indexPath.row].description
		cell.titleLabel.apply(Theme.Login.textFieldTitle)
		switch elements[indexPath.row] {
		case .username:
			cell.textField.rx.text.orEmpty
				.bind(to: usernameSubject)
				.disposed(by: cell.rx.disposeBag)
			cell.textField.apply(Theme.Login.usernameTextField)
		case .password:
			cell.textField.rx.text.orEmpty
				.bind(to: passwordSubject)
				.disposed(by: cell.rx.disposeBag)
			cell.textField.apply(Theme.Login.passwordTextField)
		}
		return cell
	}
}

private extension Selector {

	static let forgotPassword = #selector(SignInViewController.forgotPassword(sender:))
	static let createAccount = #selector(SignInViewController.createAccount(sender:))
}

extension SignInViewController {
	
	private func isUsernameValid(_ username: String) -> Observable<Bool> {
		return Observable<Bool>.create { observer in
			observer.on(Event.next(!username.isEmpty))
			return Disposables.create()
		}
	}
	
	private func isPasswordValid(_ password: String) -> Observable<Bool> {
		return Observable<Bool>.create { observer in
			observer.on(Event.next(!password.isEmpty))
			return Disposables.create()
		}
	}
	
	
	
	private func validateUsername(_ username: String, password: String) -> Observable<Result<Bool>> {
		return Observable<Result<Bool>>.create { observer in
			
			guard !username.isEmpty && !password.isEmpty else {
				let error = NSError(domain: "Validation", code: 1, userInfo: [NSLocalizedDescriptionKey: "username or password is incorrect"])
				observer.on(Event.next(Result<Bool>.failure(error)))
				return Disposables.create()
			}
			
			observer.on(Event.next(Result<Bool>.success(true)))
			
			return Disposables.create()
		}
	}
	
	private func signIn(username: String, password: String) -> Observable<Void> {
		return Observable<Void>.create { observer in
			Logger.log(event: .debug)
			observer.on(Event.next(()))
			return Disposables.create()
		}
	}
	
	private func signedIn() {
		Logger.log(event: .debug)
	}
	
	@objc fileprivate func forgotPassword(sender: Any) {
		Logger.log(event: .debug)
	}
	
	@objc fileprivate func createAccount(sender: Any) {
		Logger.log(event: .debug)
		delegate?.actionSender(self, didReceiveAction: Action.createAccount)
	}
}
