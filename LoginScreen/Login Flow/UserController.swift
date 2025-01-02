//
//  UserController.swift
//  LoginScreen
//
//  Created by Karpahalakshmi on 27/11/24.
//

import UIKit
import Combine

class UserController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: UserViewModel!
    var cancellables = Set<AnyCancellable>()
    
//    deinit {
//        cancellables.cancel()
//        printContent("Object deinitialized for login screen")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        createFieldSubscriptions()
        createBindings()
    }
    
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    fileprivate func hideSpinner() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loginButton.backgroundColor = UIColor.black
        loginButton.isEnabled = true
        loadingIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        loadingIndicator.setNeedsDisplay()
    }
}

extension UserController {
    func createBindings() {
        // Login Button Enabled
        viewModel?
            .outputs
            .canLogin
            .sink(receiveValue: { [weak self] (isEnabled) in
                self?.loginButton.backgroundColor = isEnabled ? UIColor.black : UIColor.gray
                self?.loginButton.isEnabled = isEnabled
            }).store(in: &cancellables)
        viewModel?
            .outputs
            .loginFailed
            .sink(receiveValue: { [weak self] failureInfo in
                DispatchQueue.main.async {
                    print("Login failed")
                    if !failureInfo.onRetry { self?.hideSpinner()}
                }
            })
            .store(in: &cancellables)
        viewModel?
            .outputs
            .loginSucceeded
            .sink(receiveValue: { [weak self] _ in
                print("Login Succeeded") })
            .store(in: &cancellables)
    }
    
    private func showNormalState() {
        // Reset error label
        errorLabel.text = ""
    }
    
    private func loginButtonTapped() {
        // Handle login button action
        viewModel.inputs.loginTapped()
    }
    
    func createFieldSubscriptions() {
        
        loginButton.publisher(for: .touchUpInside).sink { [weak self] _ in
            self?.loginButtonTapped()
        }
        .store(in: &cancellables)
        
        // Email text field editing changes
        emailTextField.textPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            let emailText = self.emailTextField.text ?? ""
            self.viewModel?.inputs.username(usernameValue: emailText)
            self.showNormalState()
        }
        .store(in: &cancellables)
        
        // Password text field editing changes
        passwordTextField.textPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            let passwordText = self.passwordTextField.text ?? ""
            self.viewModel?.inputs.password(passwordValue: passwordText)
            self.showNormalState()
        }
        .store(in: &cancellables)
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    func publisher(for event: UIControl.Event) -> AnyPublisher<Void, Never> {
        UIControl.EventPublisher(control: self, event: event)
            .eraseToAnyPublisher()
    }
}

extension UIControl {
    struct EventPublisher: Publisher {
        typealias Output = Void
        typealias Failure = Never
        
        private let control: UIControl
        private let event: UIControl.Event
        
        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }
        
        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = EventSubscription(subscriber: subscriber, control: control, event: event)
            subscriber.receive(subscription: subscription)
        }
        
        private final class EventSubscription<S: Subscriber>: Subscription where S.Input == Void {
            private var subscriber: S?
            private weak var control: UIControl?
            private let event: UIControl.Event
            
            init(subscriber: S, control: UIControl, event: UIControl.Event) {
                self.subscriber = subscriber
                self.control = control
                self.event = event
                control.addTarget(self, action: #selector(eventHandler), for: event)
            }
            
            func request(_ demand: Subscribers.Demand) {
                // Demand handling not required
            }
            
            func cancel() {
                subscriber = nil
            }
            
            @objc private func eventHandler() {
                _ = subscriber?.receive(())
            }
        }
    }
}

typealias Cancellables = Set<AnyCancellable>
extension Cancellables {
    mutating func cancel() {
        forEach { $0.cancel() }
        removeAll()
    }
}
