//
//  RNALiveViewController.swift
//  BookCore
//
//  Created by Umar Haroon on 5/14/20.
//

import Foundation
import UIKit
import SceneKit
import PlaygroundSupport
#if !targetEnvironment(macCatalyst)
import ARKit
#endif
@objc(BookCore_RNALiveViewController)
public class RNALiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet var loadARButton: UIButton!
    @IBOutlet weak var ARSupportLabel: UILabel!
    public override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.allowsCameraControl = true
        #if !targetEnvironment(macCatalyst)
        if !ARConfiguration.isSupported {
            loadARButton.isHidden = true
            loadARButton.isEnabled = false
            loadARButton.alpha = 0
            ARSupportLabel.alpha = 1
        }
        #else
        loadARButton.isHidden = true
        loadARButton.isEnabled = false
        loadARButton.alpha = 0
        ARSupportLabel.alpha = 1
        #endif
    }
    /*
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    }
    */

    /*
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    }
    */

    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
    }
}
