//
//  ViewController.swift
//  hellofiredb
//
//  Created by grace on 2019/12/21.
//  Copyright © 2019 grace. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var dbRef:DatabaseReference!
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var input: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //取得db reference
        dbRef = Database.database().reference()
        
        //Login
        Auth.auth().signInAnonymously { (user, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                let appNameRef = self.dbRef.child("appdefault/name")
                appNameRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
                    print("appname: \(snapshot.value as! String)")
                    self.pageTitle.text = snapshot.value as? String
                }
                let appVersionRef = self.dbRef.child("appdefault/version")
                appVersionRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
                    print("version: \(snapshot.value as! Double)")
                }
                
                let testRef = self.dbRef.child("test")
                testRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
                    self.input.text = snapshot.value as? String
                }
            }
        }
        
        

    }

    @IBAction func enterAction(_ sender: Any) {
        let inputValue = input.text ?? ""
        let dic:[String:Any] = ["name" : "Grace", "height" : 165] as [String : Any]
        let array = ["Tom", "Grace", "Kevin"]
        //取得db reference
        dbRef = Database.database().reference()
        dbRef.child("test").setValue(inputValue)
        dbRef.child("dic").setValue(dic)
        dbRef.child("array").setValue(array)
        
        dbRef.child("myTest/timestep").setValue(ServerValue.timestamp())
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        //取得db reference
        dbRef = Database.database().reference()
        dbRef.child("test").removeValue()
    }
}

