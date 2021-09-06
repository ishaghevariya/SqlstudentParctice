//
//  Students.swift
//  SqlStudent
//
//  Created by IshaGhevariya on 04/09/21.
//

import Foundation
class Students{
    var id:Int = 0
    var spid:String = ""
    var name:String = ""
    var password:String = ""
    var clas:String = ""
    var mno:String = ""
    var sem:Int = 0
    
    init(id:Int,spid:String,name:String,password:String,clas:String,mno:String,sem:Int){
        self.id = id
        self.spid = spid
        self.name = name
        self.password = password
        self.clas = clas
        self.mno = mno
        self.sem = sem
    }
}
