//
//  FeedbackController.swift
//  Andreas Neusüß
//
//  Created by Andreas Neusüß on 21.01.18.
//  Copyright © 2018 Andreas Neusüß. All rights reserved.
//  Copyright (c) 2018 Andreas Neusüß
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import UIKit


/// This enum presents the possible haptic feedback types. Each case is a type of feedback, the FeedbackController can provide.
///
/// - impact: Use this type to indicate that an impact occured. Use it for example, when UI elements collide or snap into place. It can vary between ```light```, ```medium``` and ```heavy```.
/// - selection: Use this type to indicate selection between different values. Those can be numeric or other discrete values like a switch.
/// - notification: Use this type to indicate that a task has succeded or failed. It can also be used to display a warning to the user. Usually, it uses a more complex haptics than the other types.
public enum TapticFeedbackType {
    case impact(style: UIImpactFeedbackStyle), selection, notification
}

@available(iOS 10.0, *)
/// This class can be used to control the Taptic Engine that gives the user haptic feedback.
///
/// Haptic feedback, like a tap, reinforces the users connection of UI and device in their hand. It done properly, the haptic feedback can improve the coherence between your app and the senses of the user.
/// As the Taptic Engine is a seperate mechanical component, please make a call to ```FeedbackController.prepare(for:)``` before using it. When you need to perform the haptic feedback in sync with e.g. UI interactions or even sounds, call the ```FeedbackController.prepare(for:)``` method one to two seconds before you use the feedback.
///
/// When you are done using it, call ```done()```. Then, the Taptic Engine can go into its idle state again, but needs to be prepared before another feedback can be sent.
final public class FeedbackController: NSObject {
    
    /// Use the singleton to perform preperation and actions.
    public static let shared = FeedbackController()
    
    /// The internal FeedbackGenerator that is used to perform the feedback.
    fileprivate var feedbackGenerator: UIFeedbackGenerator?
    
    private override init() {}
    
    /// Prepares the FeedbackControllers internal state and thereby the Taptic Engine to perform a haptic feedback. It should be called one to two seconds before any syncronized UI events or sounds take place in order to get the Taptic Engine into its running state.
    /// From Apples documentation:
    /// ```
    /// Preparing the generator can reduce latency when triggering feedback. This is particularly important when trying to match feedback to sound or visual cues.
    /// ```
    ///
    /// Impact type must be configured here (```.light```, ```.medium```, ```.heavy```), whereas the type of a notification needs to be set when the notification should be displayed.
    /// - Parameter type: The type of feedback that should be performed later.
    public func prepare(for type: TapticFeedbackType) {
        switch type {
        case .impact(let style):
            feedbackGenerator = UIImpactFeedbackGenerator(style: style)
            
        case .selection:
            feedbackGenerator = UISelectionFeedbackGenerator()
            
        case .notification:
            feedbackGenerator = UINotificationFeedbackGenerator()
        }
        
        feedbackGenerator?.prepare()
    }
    
    /// Removes the reference to the UIFeedbackGenerator and will cause the Taptic Engine to go into its idle state.
    /// Call this method if you are done using the feedback generator.
    /// After cannling ```done()```, make sure to call ```FeedbackController.prepare(for:)``` before you perform another feedback, otherwise the timing between the UI representation and the feedback can mismatch because the Taptic Engine needs to switch in its ``àctive``` state.
    public func done() {
        feedbackGenerator = nil
    }
    
    
    /// A call to this method performs a haptic feedback of the ```.notification``` type. By setting the argument, the type of the notification can be set, for example ```.success``` or ```.error```.
    ///
    /// ```FeedbackController.prepare(for:)``` should be called prior to this method. Otherwise the Taptic Engine is not prepared for the feedback which can lead to delays. Avoid delays when the feedback is sycronized with UI events or sound by calling ```FeedbackController.prepare(for:)``` first.
    /// - Parameter notificationType: The type of the notification.
    public func notificationOccured(_ notificationType: UINotificationFeedbackType) {
        if feedbackGenerator == nil || (feedbackGenerator is UINotificationFeedbackGenerator) == false {
            prepare(for: .notification)
            print("You should prepare before starting a feedback action! I will do it for you.")
        }
        guard let concreteFeedbackGenerator = feedbackGenerator as? UINotificationFeedbackGenerator else {
            assert(false, "The feedback generator was not instantiated prior to perform a feedback. Therefore, no haptic feedback will be given.")
            return
        }
        concreteFeedbackGenerator.notificationOccurred(notificationType)
    }
    
    
    /// /// A call to this method performs a haptic feedback of the ```.impact``` type. The type of the impact must be configured in the ```FeedbackController.prepare(for:)``` method, for example to switch between ```.light```, ```.medium``` or ```.heavy```.
    ///
    /// ```FeedbackController.prepare(for:)``` should be called prior to this method. Otherwise the Taptic Engine is not prepared for the feedback which can lead to delays. Avoid delays when the feedback is sycronized with UI events or sound by calling ```FeedbackController.prepare(for:)``` first.
    public func impactOccured() {
        if feedbackGenerator == nil || (feedbackGenerator is UIImpactFeedbackGenerator) == false {
            prepare(for: .impact(style: .medium))
            print("You should prepare before starting a feedback action! I will do it for you.")
        }
        guard let concreteFeedbackGenerator = feedbackGenerator as? UIImpactFeedbackGenerator else {
            assert(false, "The feedback generator was not instantiated prior to perform a feedback. Therefore, no haptic feedback will be given.")
            return
        }
        concreteFeedbackGenerator.impactOccurred()
    }
    
    /// /// A call to this method performs a haptic feedback of the ```.selection``` type. This kind of feedback should be used when UI elements changes, like a discrete switch.
    ///
    /// ```FeedbackController.prepare(for:)``` should be called prior to this method. Otherwise the Taptic Engine is not prepared for the feedback which can lead to delays. Avoid delays when the feedback is sycronized with UI events or sound by calling ```FeedbackController.prepare(for:)``` first.
    public func selectionChanged() {
        if feedbackGenerator == nil || (feedbackGenerator is UISelectionFeedbackGenerator) == false {
            prepare(for: .selection)
            print("You should prepare before starting a feedback action! I will do it for you.")
        }
        guard let concreteFeedbackGenerator = feedbackGenerator as? UISelectionFeedbackGenerator else {
            assert(false, "The feedback generator was not instantiated prior to perform a feedback. Therefore, no haptic feedback will be given.")
            return
        }
        concreteFeedbackGenerator.selectionChanged()
    }
}


public extension UIDevice {
    
    /// This property checks if the current device supports haptic feedback.
    /// If not, using a UIFeedbackGenerator (or FeedbackController respectively) will not work. Then, you can consider falling back onto simple vibration.
    public static var isTapticEngineSupported: Bool {
        //According to http://stackoverflow.com/questions/39564510/check-if-device-supports-uifeedbackgenerator-in-ios-10
        
        if let value = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int {
            if value == 2 {
                return true
            }
        }
        return false
    }
}

public extension UIViewController {
    
    /// This method prepares the Taptic Engine to give feedback. It uses FeedbackController. Because it is not available on all supported platforms, a #available check as well as a call to  isTapticEngineSupported is done.
    ///
    /// Call this method 1-2 seconds before the feedback occures, which should be coordinated with UI events or gestures.
    ///
    /// Impact type must be configured here (```.light```, ```.medium```, ```.heavy```), whereas the type of a notification needs to be set when the notification should be displayed.
    ///
    /// - Parameter type: The type for which the FeedbackController should prepare the Taptic Engine to.
    public func prepareFeedback(for type: TapticFeedbackType) {
        if #available(iOS 10.0, *), UIDevice.isTapticEngineSupported {
            FeedbackController.shared.prepare(for: type)
        }
    }
    
    /// This method performs haptic feedback. Can be used when the reminder or participate button is pressed. If the hardware and iOS version support it, the feedback is performed.
    /// The style of the impact (```.light```, ```.medium```, ```.heavy```) must be set by a call to ```UIViewController.prepareFeedback(for:)```.
    ///
    /// However, it does not prepare the engine. Please call ````UIViewController.prepareFeedback(for:)``` prior to the actual haptic feedback in order to improve the timing.
    public func hapticFeedbackImpactOccured() {
        if #available(iOS 10.0, *) {
            if UIDevice.isTapticEngineSupported {
                FeedbackController.shared.impactOccured()
            }
        }
    }
    
    /// This method performs haptic feedback for changes in users selection. Can be used when an alert is presented. If the hardware and iOS version support it, the feedback is performed.
    ///
    /// However, it does not prepare the engine. Please call ````UIViewController.prepareFeedback(for:)``` prior to the actual haptic feedback in order to improve the timing.
    public func hapticFeedbackSelectionChanged() {
        if #available(iOS 10.0, *) {
            if UIDevice.isTapticEngineSupported {
                FeedbackController.shared.selectionChanged()
            }
        }
    }
    
    /// This method performs haptic feedback for notification type. Can be used when an alert is presented. If the hardware and iOS version support it, the feedback is performed.
    ///
    /// The type of the notification can be set by the '''type'''.
    ///
    /// However, it does not prepare the engine. Please call ````UIViewController.prepareFeedback(for:)``` prior to the actual haptic feedback in order to improve the timing.
    ///
    /// - Parameter type: The type of notification. Use this parameter to control the style of the taptic feedback, for example if you want to present an error or warning message.
    public func hapticFeedbackNotificationOccured(with type: UINotificationFeedbackType) {
        if #available(iOS 10.0, *) {
            if UIDevice.isTapticEngineSupported {
                FeedbackController.shared.notificationOccured(type)
            }
        }
    }
    
    public func doneWithHapticFeedback() {
        if #available(iOS 10.0, *) {
            FeedbackController.shared.done()
        }
    }
}
