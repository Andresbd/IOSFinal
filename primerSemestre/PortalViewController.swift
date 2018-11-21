//
//  PortalViewController.swift
//  primerSemestre
//
//  Created by Andrés Bustamante on 11/11/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import ARKit

class PortalViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var portalAr: ARSCNView!
    @IBOutlet weak var planTexto: UILabel!
    let configuration = ARWorldTrackingConfiguration()
    var panoramaURL:String = ""
    var portalImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(panoramaURL)
        setImage()
        self.portalAr.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        //indicar la detección del plano
        self.configuration.planeDetection = .horizontal
        self.portalAr.session.run(configuration)
        self.portalAr.delegate = self
        //administrador de gestos para identificar el tap sobre el plano horizontal
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.portalAr.addGestureRecognizer(tap)

    }
    
    func setImage(){
        if let url = URL(string: panoramaURL) {
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
                self.portalImage = UIImage(data: data)
            }
        }
    }
    
    @objc func tapHandler(sender: UITapGestureRecognizer){
        guard let portalAr = sender.view as? ARSCNView else {return}
        let touchLocation = sender.location(in: portalAr)
        //obtener los resultados del tap sobre el plano horizontal
        let hitTestResult = portalAr.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        if !hitTestResult.isEmpty{
            //cargar la escena
            self.addPortal(hitTestResult: hitTestResult.first!)
        }
        else{
            // no hubo resultado
        }
    }
        
        //cargar el portal
        func addPortal(hitTestResult:ARHitTestResult){
            let portalScene = SCNScene(named:"SceneKit Asset Catalog.scnassets/portal.scn")
            let portalNode = portalScene?.rootNode.childNode(withName: "Portal", recursively: false)
            let sphereNode = portalNode?.childNode(withName: "sphere", recursively: false)
            sphereNode?.geometry?.firstMaterial?.diffuse.contents = portalImage
            //convertir las coordenadas del rayo del tap a coordenadas del mundo real
            let transform = hitTestResult.worldTransform
            let planeXposition = transform.columns.3.x
            let planeYposition = transform.columns.3.y
            let planeZposition = transform.columns.3.z
            portalNode?.position = SCNVector3(planeXposition,planeYposition,planeZposition)
            self.portalAr.scene.rootNode.addChildNode(portalNode!)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARPlaneAnchor else {return} //se agrego un plano
            //ejecución asincrona en donde se modifica la etiqueta de plano detectado
            DispatchQueue.main.async {
                self.planTexto.isHidden = false
                print("Plano detectado")
            }
            //espera 3 segundos antes de desaparecer
            DispatchQueue.main.asyncAfter(deadline: .now()+3){self.planTexto.isHidden = true}
        }
}
