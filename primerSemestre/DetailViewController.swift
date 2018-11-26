//
//  DetailViewController.swift
//  primerSemestre
//
//  Created by Andrés Bustamante on 24/10/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import WatchKit
import WatchConnectivity

class DetailViewController: UIViewController, WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    
    var lab:Any?
    var id:String?
    var horario:String?
    var destinationFileUrl:URL?
    var ModeldestinationFileUrl:URL?
    var imagesURL:[String]?
    var videoURL:String = ""
    var modelURL:URL?
    var panoURL:String = ""
    var imageIndex = 0
    var session: WCSession!

    @IBOutlet weak var imageSpinner: UIActivityIndicatorView!
    @IBOutlet weak var salon: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var theaterSpinner: UIActivityIndicatorView!
    @IBOutlet weak var modelSpinner: UIActivityIndicatorView!
    @IBOutlet weak var modelButton: UIButton!
    @IBOutlet weak var theaterButton: UIButton!
    
    @IBOutlet weak var hora: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self as! WCSessionDelegate
            session.activate()
            
            print("Sesion iniciada")
        }

        salon.text = id
        hora.text = horario
        imageSpinner.isHidden = false
        imageSpinner.startAnimating()
        //Buttons
        modelButton.isEnabled = false
        theaterButton.isEnabled = false
        setImage()
        setVideo()
        setModel()
        setPanorama()
        
    }
    
    func setImage(){
        imagesURL = ((lab! as! [String : Any])["imagen"] as? [String])!
        if let url = URL(string: imagesURL![imageIndex]) {
            imageSpinner.startAnimating()
            imageSpinner.isHidden = false
            print(url)
            downloadImage(from: url)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() {
                self.imagen.image = UIImage(data: data)
                self.imageSpinner.stopAnimating()
                self.imageSpinner.isHidden = true
            }
        }
    }
    
    func setVideo() {
        videoURL = ((lab! as! [String : Any])["video"] as? String)!
        print(videoURL)
        self.theaterSpinner.stopAnimating()
        self.theaterSpinner.isHidden = true
        self.theaterButton.isEnabled = true
    }
    
    func setModel() {
        
        modelURL = URL(string: ((lab! as! [String : Any])["material"] as? String)!)
        print(modelURL)
        self.modelSpinner.stopAnimating()
        self.modelSpinner.isHidden = true
        self.modelButton.isEnabled = true
    }
    
    func setPanorama() {
        panoURL = ((lab! as! [String : Any])["panorama"] as? String)!
        print(panoURL)
    }

    @IBAction func sedIwatch(_ sender: Any) {
        
        sendMessage()
    }
    
    func sendMessage() {
        
        print("Mandando Mensaje")
        
        session.sendMessage(["message": horario as Any], replyHandler: nil, errorHandler: {
            error in print("sending to iwatch")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ModelViewController {
            let vc = segue.destination as! ModelViewController
            vc.modURL = modelURL
            vc.navigationItem.title = "Modelo"
            }
        
        if segue.destination is VideoViewController {
            let vc = segue.destination as! VideoViewController
            vc.navigationItem.title = "Video"
            vc.videoURL = videoURL
        }
        if segue.destination is PortalViewController {
            let vc = segue.destination as! PortalViewController
            vc.panoramaURL = panoURL
            vc.navigationItem.title = "Panorama"
        }
        }
    }
