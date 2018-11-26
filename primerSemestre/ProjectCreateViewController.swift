//
//  ProjectCreateViewController.swift
//  primerSemestre
//
//  Created by Luis Eduardo Brime Gomez on 11/26/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import Firebase

class ProjectCreateViewController: UIViewController, UITextFieldDelegate {

    var projectNum: Int = 0
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var salonField: UITextField!
    
    @IBOutlet weak var created: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction func create(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        
        var ref: DatabaseReference
        ref = Database.database().reference()
        
        let n = nameField.text ?? ""
        let d = dateField.text ?? ""
        let s = salonField.text ?? ""
        let key: String = "Project\(projectNum+1)"
        
        
        ref.child("users").child(Global.sharedManager.user).child("projects").updateChildValues([key: ["name": n, "deadline": d, "salon": s, "done": false]]) {
            (error: Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data not saved. \(error).")
            } else {
                print("Data saved!")
                self.created.isHidden = false
            }
        }
        
        nameField.text = ""
        dateField.text = ""
        salonField.text = ""
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        indicator.isHidden = true
        created.isHidden = true
        print(projectNum)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
