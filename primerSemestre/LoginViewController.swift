//
//  LoginViewController.swift
//  primerSemestre
//
//  Created by Luis Eduardo Brime Gomez on 11/26/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var currentUserText: UILabel!
    
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var proyectos: UIButton!
    
    @IBOutlet weak var error: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var logged : Bool = false
    
    @IBAction func login(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("users").child(username.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let pass = value?["password"] as? String ?? ""
        
            if pass == self.password.text {
                Global.sharedManager.user = self.username.text!
                self.error.isHidden = true
            } else {
                self.error.isHidden = false
            }
            
            self.indicator.stopAnimating()
            self.viewDidLoad()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        Global.sharedManager.user = ""
        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.username.delegate = self
        self.password.delegate = self
        
        username.text = ""
        password.text = ""
        indicator.isHidden = true
        
        var currentUser = Global.sharedManager.user
        if currentUser == "" {
            currentUserText.text = "No active user"
            logout.isEnabled = false
        } else {
            currentUserText.text = currentUser
            logout.isEnabled = true
            proyectos.isHidden = false
        }
        
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
