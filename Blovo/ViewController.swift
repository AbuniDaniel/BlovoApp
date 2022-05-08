//
//  ViewController.swift
//  Blovo
//
//  Created by user215931 on 5/2/22.
//

import UIKit
import FirebaseAuth
import SafariServices
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var restaurante: UIButton!
    @IBOutlet weak var video: UIButton!
    @IBOutlet weak var sitewebbutton: UIButton!
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log in"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    // sfsafari
    @IBAction func siteweb(_ sender: UIButton) {
        if let url = URL(string: "https://glovoapp.com/ro/ro/"){
            let safariVC = SFSafariViewController(url: url)
            
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "email Address"
        emailField.layer.borderWidth = 1
        emailField.autocapitalizationType = .none
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.backgroundColor = .white
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return emailField
    }()

    private let passwordField: UITextField = {
        let passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.borderWidth = 1
        passField.isSecureTextEntry = true
        passField.layer.borderColor = UIColor.black.cgColor
        passField.backgroundColor = .white
        passField.leftViewMode = .always
        passField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return passField
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        return button
        
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("log out", for: .normal)
        return button
        
    }()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(button)
        view.addSubview(signOutButton)
        signOutButton.isHidden = true
        
        video.isHidden = true
        sitewebbutton.isHidden = true
        restaurante.isHidden = true
        
        view.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapButton) , for: .touchUpInside)
        // Do any additional setup after loading the view.
        
        //notifications
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound])
        {
            (granted, error) in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Asta este o notfificare"
        content.body = "Te asteptam pe Blovo!"
        
        let date = Date().addingTimeInterval(5)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request){ (error) in
            
        }
        
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            label.isHidden = true
            button.isHidden = true
            emailField.isHidden = true
            passwordField.isHidden = true
            video.isHidden = false
            sitewebbutton.isHidden = false
            restaurante.isHidden = false
            signOutButton.isHidden = false
            signOutButton.frame = CGRect(x: 20, y: 750, width: view.frame.width-40, height: 52)
            signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }
        
    }
    
    @objc private func logOutTapped(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            label.isHidden = false
            button.isHidden = false
            emailField.isHidden = false
            passwordField.isHidden = false
            video.isHidden = true
            sitewebbutton.isHidden = true
            restaurante.isHidden = true
            signOutButton.isHidden = true
            
        }
        catch{
            print("An error occurred")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0 , y: 100, width: view.frame.size.width, height: 80)
        emailField.frame = CGRect(x: 20 ,
                                  y: label.frame.origin.y + label.frame.size.height + 10,
                                  width: view.frame.size.width - 40,
                                  height: 50)
        passwordField.frame = CGRect(x: 20 ,
                                 y: emailField.frame.origin.y + emailField.frame.size.height + 10,
                                 width: view.frame.size.width - 40,
                                 height: 50)
        button.frame = CGRect(x: 20 ,
                              y: passwordField.frame.origin.y + passwordField.frame.size.height + 20,
                              width: view.frame.size.width - 40,
                              height: 40)
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseAuth.Auth.auth().currentUser == nil{
            emailField.becomeFirstResponder()
        }
        
    }
    
    @objc private func didTapButton(){
        print("Continue button tapped")
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else{
                  printContent("Missing field data")
                  return
              }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self]result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
                    
                    
        print("You have signed in")
            strongSelf.label.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.button.isHidden = true
            strongSelf.video.isHidden = false
            strongSelf.sitewebbutton.isHidden = false
            strongSelf.restaurante.isHidden = false
            strongSelf.signOutButton.isHidden = false
            strongSelf.emailField.resignFirstResponder()
            strongSelf.passwordField.resignFirstResponder()
        })
        
    }
    
    func showAccFailed(){
        let  alertAccFailed = UIAlertController(title: "ERROR", message: "Account creation failed (invalid mail/mail already exists/password too short)", preferredStyle: .alert)

        alertAccFailed.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                self.present(alertAccFailed, animated: true, completion: nil)
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would you like to create an account?",
                                      preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self]result, error in
                guard let strongSelf = self else{
                    return
                }
                guard error == nil else{
                    strongSelf.showAccFailed()
                    print("Account creation failed")
                    return
                }
                        
                        
            print("You have signed in")
                strongSelf.label.isHidden = true
                strongSelf.emailField.isHidden = true
                strongSelf.passwordField.isHidden = true
                strongSelf.button.isHidden = true
                strongSelf.video.isHidden = false
                strongSelf.sitewebbutton.isHidden = false
                strongSelf.restaurante.isHidden = false
                strongSelf.signOutButton.isHidden = false
                strongSelf.emailField.resignFirstResponder()
                strongSelf.passwordField.resignFirstResponder()
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: {_ in
            
        }))
        
        present(alert, animated: true)
    }
}

