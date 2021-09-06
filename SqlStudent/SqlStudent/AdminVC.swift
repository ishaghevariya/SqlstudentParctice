//
//  AdminVC.swift
//  SqlStudent
//
//  Created by IshaGhevariya on 04/09/21.
//

import UIKit

class AdminVC: UIViewController {
    let adminToken = UserDefaults.standard.string(forKey: "sessionAdmin")
    let adminname = UserDefaults.standard.string(forKey: "admin")
    
    private let Addbutton:UIButton = {
        let button = UIButton()
        button.setTitle("AddStudent", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handlestudent), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let Noticebord:UIButton = {
       let button = UIButton()
        button.setTitle("AddNotice", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handleNotice), for: .touchUpInside)
        button.layer.cornerRadius = 20
       return button
    }()
    
    private let LogOut:UIButton = {
        let button = UIButton()
        button.setTitle("LogOut", for: .normal)
        button.backgroundColor  = .black
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
        return button
    }()
    @objc func handlestudent(){
        let vc = StudentDisplayVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func handleNotice(){
        let vc = NoticeBoardVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func handleLogOut(){
        print("Session is Clear")
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(Addbutton)
        view.addSubview(Noticebord)
        view.addSubview(LogOut)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Addbutton.frame = CGRect(x: 30, y: 100, width: view.width - 40, height: 60)
        Noticebord.frame = CGRect(x: 30, y: Addbutton.bottom + 10, width: view.width - 40, height: 60)
        LogOut.frame = CGRect(x: 30, y: Noticebord.bottom + 10, width: view.width - 40, height: 60)
    }
}
