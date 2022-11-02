//
//  AppDatabase.swift
//  pettri-ios-sdk
//
//  Created by jasonyeong790 on 02/11/2022.
//

import Foundation
import SQLite3

class AppDatabase{
    
    var db:OpaquePointer?

    let table:String    = "AppData"
    
    let path:String     = "DSDatabase.sqlite"
    
    init(db: OpaquePointer? = nil) {
        self.db = createDB()
        createTable()
    }
    
    
    
    /*** Create SQLite3 Database **/
    func createDB() -> OpaquePointer? {
            
        var db : OpaquePointer? = nil
        do {
            
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
                    
            if sqlite3_open(filePath.path, &db) == SQLITE_OK {
                print("[PETTRI]Succesfully create Database path : \(filePath.path)")
                return db
            }
                
        }catch{
            print("ERROR in CreateDB - \(error.localizedDescription)")
        }
            
        print("ERROR in CreateDB - sqlite3_open ")
        return nil
            
    }
    
    
    
    
    
    /*** Create table newly if not exists */
    func createTable(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
            
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("table not exsist")
        }
            
        let CREATE_QUERY_TEXT : String = "CREATE TABLE IF NOT EXISTS \(table) (id INTEGER PRIMARY KEY AUTOINCREMENT, click_key TEXT, tracking_id TEXT)"

        if sqlite3_exec(db, CREATE_QUERY_TEXT, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString:sqlite3_errmsg(db))
                print("db table create error : \(errMsg)")
        }
        
    }
    
    
    
    
    
    /*** Insert new row data into SQLite3 database. */
    func insert(_ clickKey : String,_ trkId : String){
        
        
        var stmt : OpaquePointer?
            
        let INSERT_QUERY_TEXT : String = "INSERT INTO \(table) (click_key, tracking_id) Values (?,?)"

        if sqlite3_prepare(db, INSERT_QUERY_TEXT, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert:v1 \(errMsg)")
            return
        }
            
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            
        if sqlite3_bind_text(stmt, 1, clickKey, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("failture binding name: \(errMsg)")
            return
        }

        if sqlite3_bind_text(stmt, 2, trkId, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("failture binding name: \(errMsg)")
            return
        }
 
            
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("insert fail :: \(errMsg)")
            return
        }
    
    }
    
    
    
    
    /*** Find saved app data from SQLite3 database */
    func setupAppData(){
            
        let SELECT_QUERY = "SELECT * FROM \(table)"
        var stmt:OpaquePointer?
            
            
        if sqlite3_prepare(db, SELECT_QUERY, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1\(errMsg)")
            return
        }
            
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let clickKey = String(cString: sqlite3_column_text(stmt, 1))
            let trackingId = String(cString: sqlite3_column_text(stmt, 2))
        
            print("[PETTRI]Setting up click key["+clickKey+"] and tracking id["+trackingId+"] into pettri module... success. ")
            
            pettri.setup(clickKey:clickKey, trackingId:trackingId)
        }
      
    }
    
    
    
    
    /*** Update current row data with given parameters. */
    func update(_ index:String, _ clickKey : String,_ trkId : String){
        let UPDATE_QUERY = "UPDATE \(table) Set title = '\(clickKey)', subline = '\(trkId)' WHERE id == \(index)"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, UPDATE_QUERY, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing update: v1\(errMsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("update fail :: \(errMsg)")
            return
        }
        
        sqlite3_finalize(stmt)
        print("update success")
               
    }
    
    
    
    /*** Delete row from SQLite3 database with row index */
    func delete(_ index:String){
            let DELETE_QUERY = "DELETE FROM \(table) WHERE id = \(index)"
            var stmt:OpaquePointer?
            
            if sqlite3_prepare_v2(db, DELETE_QUERY, -1, &stmt, nil) != SQLITE_OK{
                let errMsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing delete: v1\(errMsg)")
                return
            }
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errMsg = String(cString : sqlite3_errmsg(db)!)
                print("delete fail :: \(errMsg)")
                return
            }
            sqlite3_finalize(stmt)
                    
        }
    
    
}


var appDatabase = AppDatabase()

