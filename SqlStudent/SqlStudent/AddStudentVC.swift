//
//  AddStudentVC.swift
//  SqlStudent
//
//  Created by IshaGhevariya on 04/09/21.
//

import UIKit

class AddStudentVC: UIViewController {

    var students:Students?
    
    private let rollNotextFeild:UITextField = {
       let textFeild = UITextField()
        textFeild.textAlignment = .center
        textFeild.placeholder = "Enter Roll Number:"
        textFeild.autocapitalizationType = .none
        textFeild.layer.cornerRadius = 10
        textFeild.borderStyle = .roundedRect
        return textFeild
    }()
    
    private let nameTextFeild:UITextField = {
       let texFeild = UITextField()
        texFeild.textAlignment = .center
        texFeild.placeholder = "Enter Name:"
        texFeild.autocapitalizationType = .none
        texFeild.layer.cornerRadius = 10
        texFeild.borderStyle = .roundedRect
        return texFeild
    }()
    
    private let passwordTextFeild:UITextField = {
       let textFeild = UITextField()
        textFeild.textAlignment = .center
        textFeild.placeholder = "Enter Password"
        textFeild.autocapitalizationType = .none
        textFeild.layer.cornerRadius = 10
        textFeild.borderStyle = .roundedRect
        return textFeild
    }()
    
    private let classTextFeild:UITextField = {
       let textFeild = UITextField()
        textFeild.textAlignment = .center
        textFeild.placeholder = "Enter Your Class"
        textFeild.autocapitalizationType = .none
        textFeild.layer.cornerRadius = 10
        textFeild.borderStyle = .roundedRect
        return textFeild
    }()
    
    private let mnoTextFeild:UITextField = {
        let textfeild = UITextField()
        textfeild.textAlignment = .center
        textfeild.placeholder = "Enter Mobile Number"
        textfeild.autocapitalizationType = .none
        textfeild.layer.cornerRadius = 10
        textfeild.borderStyle = .roundedRect
        return textfeild
    }()
    
    private let semTextFeild:UITextField = {
       let textFeild = UITextField()
        textFeild.textAlignment = .center
        textFeild.placeholder = "Enter Sem"
        textFeild.autocapitalizationType = .none
        textFeild.layer.cornerRadius = 10
        textFeild.borderStyle = .roundedRect
        return textFeild
    }()
    
    private let saveButton:UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc func handleSave() {
        let spid = rollNotextFeild.text!
        let name = nameTextFeild.text!
        let password = passwordTextFeild.text!
        let clas = classTextFeild.text!
        let mno = mnoTextFeild.text!
        let sem = Int(semTextFeild.text!)!
        let stud = Students(id: 0, spid: spid, name: name, password: password, clas: clas, mno: mno, sem: sem)
        insert(stud: stud)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(rollNotextFeild)
        view.addSubview(nameTextFeild)
        view.addSubview(passwordTextFeild)
        view.addSubview(classTextFeild)
        view.addSubview(mnoTextFeild)
        view.addSubview(semTextFeild)
        view.addSubview(saveButton)
        
        if let stud = students{
            rollNotextFeild.text = stud.spid
            nameTextFeild.text = stud.name
            passwordTextFeild.text = stud.password
            classTextFeild.text = stud.clas
            mnoTextFeild.text = stud.mno
            semTextFeild.text = String(stud.sem)
        }

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rollNotextFeild.frame = CGRect(x: 40, y: 100, width: view.width - 20, height: 50)
        nameTextFeild.frame = CGRect(x: 40, y: rollNotextFeild.bottom + 10, width: view.width - 20, height: 50)
        passwordTextFeild.frame = CGRect(x: 40, y: nameTextFeild.bottom + 10, width: view.width - 20, height: 50)
        classTextFeild.frame = CGRect(x: 40, y: passwordTextFeild.bottom + 10, width: view.width - 20, height: 50)
        mnoTextFeild.frame = CGRect(x: 40, y: classTextFeild.bottom + 10, width: view.width - 20, height: 50)
        semTextFeild.frame = CGRect(x: 40, y: mnoTextFeild.bottom + 10, width: view.width - 20, height: 50)
        saveButton.frame = CGRect(x: 40, y: semTextFeild.bottom + 30, width: view.width - 20, height: 50)
    }
    
    private func insert(stud:Students){
        SQLiteHandler.shared.insert(stud: stud){[weak self] success in
            if success {
                let alert = UIAlertController(title: "Oppss!!", message: "Data Save Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }))
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            else{
                let alert = UIAlertController(title: "Opps!!", message: "Issue on saving data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
