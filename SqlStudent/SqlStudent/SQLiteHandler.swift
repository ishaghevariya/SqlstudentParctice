//
//  SQLiteHandler.swift
//  SqlStudent
//
//  Created by IshaGhevariya on 04/09/21.
//

import Foundation
import SQLite3

class SQLiteHandler {
    
    static let shared = SQLiteHandler()
    let dbPath = "StudentDB.Sqlite"
    var db:OpaquePointer?
    
    private init()
    {
        db = openDatabase()
        createTable()
    }
    
    func openDatabase() -> OpaquePointer?{
        let docurl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileurl = docurl.appendingPathComponent(dbPath)
        var database:OpaquePointer? = nil
        if sqlite3_open(fileurl.path, &database) == SQLITE_OK{
            print("Open Connection SuccessFully at: \(fileurl)")
            return database
        }
        else{
            print("database not connected")
            return nil
        }
  }
    
    func createTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS Student(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            spid TEXT,
            name TEXT,
            password TEXT,
            clas TEXT,
            mno TEXT,
            sem INTEGER);
            """
        var createTableStatement:OpaquePointer?=nil
        if sqlite3_prepare_v2(db, createTableString, -1,&createTableStatement,nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Student Table Create Successfully")
            }
            else{
                print("Can't create table")
            }
        }
        else{
            print("Table not created")
        }
        sqlite3_finalize(createTableStatement)
}
    
    func insert(stud:Students,completion:@escaping((Bool) -> Void)){
        let insertStatementString = "INSERT INTO Student(spid,name,password,clas,mno)  VALUES (?,?,?,?,?);"
        var insertStatement:OpaquePointer?=nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
            sqlite3_bind_text(insertStatement, 1, (stud.spid as NSString).utf8String, -1 ,nil)
            sqlite3_bind_text(insertStatement, 2, (stud.name as NSString).utf8String, -1,nil)
            sqlite3_bind_text(insertStatement, 3, (stud.password as NSString).utf8String, -1 ,nil)
            sqlite3_bind_text(insertStatement, 4,(stud.clas as NSString).utf8String,-1,nil)
            sqlite3_bind_text(insertStatement,5,(stud.mno as NSString).utf8String,-1,nil)
            sqlite3_bind_int(insertStatement, 6, Int32(stud.sem))
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insert row Successfully")
                completion(true)
            }
            else{
                print("row not insertedd")
                completion(false)
            }
        }else{
            print("inseted statement false")
            completion(false)
        }
        sqlite3_finalize(insertStatement)
    }
    
    func fetch()->[Students] {
        let fetchStatementString = "SELECT * FROM Student;"
        var fetchStatement:OpaquePointer?=nil
        var stud = [Students]()
        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil)==SQLITE_OK {
            while sqlite3_step(fetchStatement)==SQLITE_ROW{
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let spid = String(cString: sqlite3_column_text(fetchStatement, 1))
                let name = String(cString: sqlite3_column_text(fetchStatement,2))
                let password = String(cString: sqlite3_column_text(fetchStatement, 3))
                let clas = String(cString: sqlite3_column_text(fetchStatement,4))
                let mno = String(cString: sqlite3_column_text(fetchStatement, 5))
                let sem = Int(sqlite3_column_int(fetchStatement, 6))
                stud.append(Students(id: id, spid: spid, name: name, password: password, clas: clas, mno: mno ,sem: sem))
                print("\(id) | \(spid) | \(name) | \(password) | \(clas) | \(mno) | \(sem)")
                
            }
        }else{
            print("Statement Failed")
        }
        sqlite3_finalize(fetchStatement)
        return stud
    }
}
