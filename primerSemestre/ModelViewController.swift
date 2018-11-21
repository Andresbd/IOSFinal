//
//  ModelViewController.swift
//  primerSemestre
//
//  Created by Andrés Bustamante on 25/10/18.
//  Copyright © 2018 Andrés Bustamante. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ModelViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var model: ARSCNView!
    var modURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(modURL)
        // Set the view's delegate
        model.delegate = self
        
        // Show statistics such as fps and timing information
        model.showsStatistics = false
        
        // Create a new scene
        do {
            let scene = try? SCNScene(url: modURL!, options: nil)
            model.scene = scene!
        }catch {
            print("There was an error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        model.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        model.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
