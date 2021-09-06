//
//  ViewController.swift
//  SqlStudent
//
//  Created by IshaGhevariya on 04/09/21.
//

import UIKit

class ViewController: UIViewController {
    private var studArray = [Students]()

    private let UserName:UITextField = {
       let uname = UITextField()
        uname.placeholder = "Enter UserName"
        uname.autocapitalizationType = .none
        uname.textAlignment = .center
        uname.layer.cornerRadius = 20
        uname.borderStyle = .roundedRect
        return uname
    }()
    
    private let password:UITextField = {
       let pwd = UITextField()
        pwd.placeholder = "Enter Password"
        pwd.textAlignment = .center
        pwd.isSecureTextEntry = true
        pwd.layer.cornerRadius = 20
        pwd.borderStyle = .roundedRect
        return pwd
    }()
    
    private let btnlogin:UIButton = {
       let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
    @objc func handleLogin(){
        if UserName.text == "admin" && password.text == "admin"{
            UserDefaults.standard.setValue("adminsession", forKey: "sessionAdmin")
            UserDefaults.standard.setValue(UserName.text, forKey: "admin")
            self.dismiss(animated:true)
            let vc = AdminVC()
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let alert = UIAlertController(title: "oops!", message: "Please enter valid username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismmis", style:.cancel))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(UserName)
        view.addSubview(password)
        view.addSubview(btnlogin)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UserName.frame = CGRect(x: 30, y: 150, width: view.width - 60, height: 40)
        password.frame = CGRect(x: 30, y: UserName.bottom + 10, width: view.width - 60, height: 40)
        btnlogin.frame = CGRect(x: 30, y: password.bottom + 30, width: view.width - 80, height: 40)
    }
}

