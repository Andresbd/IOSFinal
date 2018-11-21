//
//  SalonesTableViewController.swift
//  primerSemestre
//
//  Created by Andrés Bustamante on 17/09/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit

class SalonesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var idPiso: Any?
    
    var datosFiltrados:[Any] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            datosFiltrados = nuevoArray!
        } else {
            
            datosFiltrados = nuevoArray!.filter{
            let objetoSalon=$0 as! [String:Any]
            let s:String = objetoSalon["nombre"] as! String;
            return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    
    let direccion="http://martinmolina.com.mx/201813/data/Andres/andres.json"
    var nuevoArray:[Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)
        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
        for i in nuevoArray! {
            let objectSalon = i as! [String:Any]
            if((objectSalon["piso"]! as! String) == (idPiso! as! String)){
                datosFiltrados.append(i)
            }
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datosFiltrados.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Salones", for: indexPath)
        
        let objetoMarca = datosFiltrados[indexPath.row] as! [String: Any]
        let s:String = objetoMarca["nombre"] as! String
        
        cell.textLabel?.text=s
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if(segue.destination is DetailViewController){
                let vc = segue.destination as! DetailViewController
                let selectedLab = datosFiltrados[(tableView.indexPathForSelectedRow?.row)!] as! [String : Any]
                vc.lab = selectedLab
                vc.horario = selectedLab["horario"] as? String
                vc.id = selectedLab["id"] as? String
                vc.navigationItem.title = selectedLab["nombre"] as? String
            }
            
        }
    }
