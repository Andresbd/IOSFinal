//
//  ProjectDetailViewController.swift
//  primerSemestre
//
//  Created by Luis Eduardo Brime Gomez on 11/26/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import Firebase

class ProjectDetailViewController: UIViewController {
    var pName: String = ""
    
    @IBOutlet weak var pNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var salonLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        indicator.isHidden = true
        loadData()
    }
    
    func loadData() {
        indicator.isHidden = false
        indicator.startAnimating()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("users").child(Global.sharedManager.user).child("projects").child(pName).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let n = value?["name"] as? String ?? ""
            let dl = value?["deadline"] as? String ?? ""
            let d = value?["done"] as? Bool ?? false
            let s = value?["salon"] as? String ?? ""
            
            self.pNameLabel.text = n
            self.dateLabel.text = dl
            self.salonLabel.text = s
            
            if d {
                self.statusLabel.backgroundColor = UIColor.green
            } else {
                self.statusLabel.backgroundColor = UIColor.red
            }
            
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        })
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
