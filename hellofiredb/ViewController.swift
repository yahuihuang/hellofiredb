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
                }
                let appVersionRef = self.dbRef.child("appdefault/version")
                appVersionRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
                    print("version: \(snapshot.value as! Double)")
                }
            }
        }
        
        

    }


}

