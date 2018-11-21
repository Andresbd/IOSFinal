//
//  PanoramaViewController.swift
//  primerSemestre
//
//  Created by Andrés Bustamante on 11/11/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import CTPanoramaView

class PanoramaViewController: UIViewController {
    
    var panoramaURL:String = ""

    @IBOutlet weak var panorama: CTPanoramaView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setImage()
    }
    @IBAction func cylindrical(_ sender: Any) {
        if panorama.panoramaType == .spherical {
            loadCylindricalImage()
        } else {
            loadSphericalImage()
        }
    }
    @IBAction func motionTyped(_ sender: Any) {
        if panorama.controlMethod == .touch {
            panorama.controlMethod = .motion
        } else {
            panorama.controlMethod = .touch
        }
    }
    
    func setImage(){
        if let url = URL(string: panoramaURL!) {
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
                panorama.image = UIImage(data: data)
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
