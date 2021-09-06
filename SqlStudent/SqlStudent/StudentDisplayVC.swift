//
//  StudentDisplayVC.swift
//  SqlStudent
//
//  Created by IshaGhevariya on 04/09/21.
//

import UIKit

class StudentDisplayVC: UIViewController {

    private var studArray = [Students]()
    private let StudTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        studArray = SQLiteHandler.shared.fetch()
        StudTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Student"
        view.backgroundColor = .white
        let additem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addnewStudent))
        view.addSubview(StudTableView)
        navigationItem.setRightBarButton(additem, animated: true)
        setTableView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        StudTableView.frame = view.bounds
    }
    @objc func addnewStudent(){
        let vc = AddStudentVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StudentDisplayVC : UITableViewDataSource , UITableViewDelegate {
    
    private func setTableView(){
        StudTableView.register(UITableViewCell.self, forCellReuseIdentifier: "stud")
        StudTableView.delegate = self
        StudTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stud", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.textLabel?.text = "\(stud.spid) \t | \(stud.name) \t | \(stud.password) \t | \(stud.clas) \t | \(stud.mno) \t | \(stud.sem)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = AddStudentVC()
        vc.students = studArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
