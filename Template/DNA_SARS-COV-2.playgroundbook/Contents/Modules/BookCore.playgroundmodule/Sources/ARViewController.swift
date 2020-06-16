//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  A source file which is part of the auxiliary module named "BookCore".
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import SceneKit
#if !targetEnvironment(macCatalyst)
import ARKit
import PlaygroundSupport

@objc(BookCore_ARViewController)
public class ARViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!

    @IBOutlet weak var statusLabel: UILabel!

    var planes: Dictionary<UUID, Plane>!
    public override func viewDidLoad() {
        super.viewDidLoad()
        //        ARView.showsStatistics = true

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//        sceneView.debugOptions = SCNDebugOptions(arrayLiteral: [.showFeaturePoints, .showWorldOrigin])
        // Create a new scene
        //        let scene = SCNScene(named: "art.scnassets/DNA.scn")!
        self.planes = [:]
        // Set the scene to the view
        //        sceneView.scene = scene
        sceneView.allowsCameraControl = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(recognizer:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        layoutButton()
    }
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    func layoutButton() {
        let button = UIButton(type: .close)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44).isActive = true
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    @objc func handleTapGestureRecognizer(recognizer: UITapGestureRecognizer) {
        let tapPoint = recognizer.location(in: self.view)
        let arrayResults = self.sceneView.hitTest(tapPoint, types: ARHitTestResult.ResultType.existingPlaneUsingExtent)
        if arrayResults.isEmpty {
            return
        }
        guard let hitResult = arrayResults.first else { return }
        insertGeometry(hitResult: hitResult)
    }
    func insertGeometry(hitResult: ARHitTestResult) {
        let dimension = Float(0.001)
        let scene = SCNScene(named: "DNANew.scn")
        guard let DNANode = scene?.rootNode.childNode(withName: "DNA", recursively: true) else { return }

        DNANode.position = SCNVector3Make(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        DNANode.scale = SCNVector3Make(dimension, dimension, dimension)

        self.sceneView.scene.rootNode.addChildNode(DNANode)

        let configuration = ARWorldTrackingConfiguration()
        // Run the view's session
        sceneView.session.run(configuration)
    }
    // MARK: - ARSCNViewDelegate


    // Override to create and configure nodes for anchors added to the view's session.
    public func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        return node
    }
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let plane = Plane(with: planeAnchor)

        self.planes[anchor.identifier] = plane
        node.addChildNode(plane)
        DispatchQueue.main.async {
            self.statusLabel.text = "Found a surface! Tap to add DNA!"
        }
    }
    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let plane = self.planes[anchor.identifier] else { return }
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        plane.update(anchor: planeAnchor)
    }
    public func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        self.planes.removeValue(forKey: anchor.identifier)
    }
    public func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    public func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    public func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }
}
#endif
