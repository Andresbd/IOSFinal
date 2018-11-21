//
//  ListaTableViewController.swift
//  primerSemestre
//
//  Created by Andrés Bustamante on 09/09/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit

class ListaTableViewController: UITableViewController {
    
    private let pisos = ["Primer piso", "Segundo piso", "Tercer piso", "Cuarto piso"]
    let identificador = "Table View"
    
    var nuevoArray:[Any]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return pisos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Table View", for: indexPath)
        
        cell.textLabel?.text=pisos[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sigVista=segue.destination as! SalonesTableViewController
        var indice=self.tableView.indexPathForSelectedRow?.row
        
        if indice == 0 {
            sigVista.idPiso = "1"
        }else if indice == 1{
            sigVista.idPiso = "2"
        }else if indice == 2{
            sigVista.idPiso = "3"
        }else if indice == 3 {
                sigVista.idPiso = "4"
        }
        }

}
