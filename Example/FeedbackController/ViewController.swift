//
//  ViewController.swift
//  FeedbackController
//
//  Created by github@anerma.de on 05/17/2018.
//  Copyright (c) 2018 github@anerma.de. All rights reserved.
//

import UIKit
import AudioToolbox
import FeedbackController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prepare the Taptic Engine here because in a few seconds buttons will be pushed and a feedback is expected.
        // In this state, we need to prepare for something, yet we do not know what to prepare for.
        // On what type you start your preparation is not important. The main thing is that the Taptic Engine is in its active state.
        prepareFeedback(for: .impact(style: .medium))
        
        // Show a warning if the current device does not support the Taptic Engine.
        if UIDevice.isTapticEngineSupported == false {
            tapticEngineIsMissing()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Stop the feedback so that the Taptic Engine can transition to its idle state.
        doneWithHapticFeedback()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// MARK: Type Impact
    @IBAction func impactHeavy(_ sender: Any) {
        prepareFeedback(for: .impact(style: .heavy))
        hapticFeedbackImpactOccured()
    }
    @IBAction func impactMedium(_ sender: Any) {
        prepareFeedback(for: .impact(style: .medium))
        hapticFeedbackImpactOccured()
    }
    @IBAction func impactLight(_ sender: Any) {
        prepareFeedback(for: .impact(style: .light))
        hapticFeedbackImpactOccured()
    }
    
    /// MARK: Type Notification
    @IBAction func notificationSuccess(_ sender: Any) {
        prepareFeedback(for: .notification)
        hapticFeedbackNotificationOccured(with: .success)
    }
    @IBAction func notificationError(_ sender: Any) {
        prepareFeedback(for: .notification)
        hapticFeedbackNotificationOccured(with: .error)
    }
    @IBAction func notificationWarning(_ sender: Any) {
        prepareFeedback(for: .notification)
        hapticFeedbackNotificationOccured(with: .warning)
    }
    
    /// MARK: Type Selection
    @IBAction func selection(_ sender: Any) {
        prepareFeedback(for: .selection)
        hapticFeedbackSelectionChanged()
    }
    
    private func tapticEngineIsMissing() {
        // Vibrate and show a warning.
        
        let alert = UIAlertController(title: "Taptic Engine Missing", message: "The device does not support haptic feedback as there is no Taptic Engine built into it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        
    }
}

