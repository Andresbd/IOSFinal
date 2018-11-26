//
//  ProjectTableViewController.swift
//  primerSemestre
//
//  Created by Luis Eduardo Brime Gomez on 11/26/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import Firebase

class ProjectTableViewController: UITableViewController {

    var datos: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadProjects()
    }
    
    func loadProjects() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("users").child(Global.sharedManager.user).child("projects").observe(.childAdded, with: { (snap) in
            print(snap)
            let p = snap.key
            
            self.datos.append(p)
            
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datos.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Project", for: indexPath)
        
        cell.textLabel?.text = datos[indexPath.row] as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleP" {
            let nextView = segue.destination as! ProjectDetailViewController
            let indice = self.tableView.indexPathForSelectedRow?.row
            
            nextView.pName = datos[indice!] as! String
        } else if segue.identifier == "createP" {
            let nextView = segue.destination as! ProjectCreateViewController
            
            print("Data \(datos.count)")
            nextView.projectNum = datos.count
        }
    }
}
