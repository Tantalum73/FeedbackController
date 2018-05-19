# FeedbackController

[![CI Status](https://img.shields.io/travis/github@anerma.de/FeedbackController.svg?style=flat)](https://travis-ci.org/github@anerma.de/FeedbackController)
[![Version](https://img.shields.io/cocoapods/v/FeedbackController.svg?style=flat)](https://cocoapods.org/pods/FeedbackController)
[![License](https://img.shields.io/cocoapods/l/FeedbackController.svg?style=flat)](https://cocoapods.org/pods/FeedbackController)
[![Platform](https://img.shields.io/cocoapods/p/FeedbackController.svg?style=flat)](https://cocoapods.org/pods/FeedbackController)


The Taptic Engine was introduced in Apples iPhone 7. It not only made possible to replace the mechanical home button but it also introduced API for developers. Through this API it became possible to give the user a subtle mechanical feedback about what is happening on screen.

For example an app can combine user interactions (like tapping a button, fading a slider oder flipping a view) with a light shake of the phone.<br>
Even more sophisticated feedback types are possible. A notification can be combined with the according haptic feedback and then the user can literally feel if a task was successful or not.

#### Implementation of standard APIs
To integrate the haptic feedback, one must use ```UIFeedbackGenerator```. This superclass is derived by three different subclasses: ```UIImpactFeedbackGenerator```, ```UINotificationFeedbackGenerator``` and ```UISelectionFeedbackGenerator```.<br>
These three subclasses can be used for three different types of feedback:
1. A single tap-like feedback provided by ```UIImpactFeedbackGenerator```
2. A more complex feedback to indicate that a task has completed (successfully / erroneous) or that a warning occurred by using ```UINotificationFeedbackGenerator```
3. A single tap that implies a change in the users selection, for example when a switch is used or an image snaps into place, provided by ```UISelectionFeedbackGenerator```

In any case, the Taptic Engine must be transitioned into its active state, by calling ```prepare()``` on any of the mentioned subclasses. To align the UI interaction or even sounds with the haptic feedback, ```prepare``` should be called about one or two seconds in advance.


### What FeedbackController does
As it turns out, the API is not as straight forward as it could be. For example, the type of the notification-feedback is set when the feedback should fire.<br>
Then again, the type of an impact feedback must be set during the ```prepare``` state.<br>
In addition to that, the API is only available on iPhone 7 or newer, running iOS 11 or higher. Prior to using the described APIs, one must perform availability checks. As a reference to the ```UIFeedbackGenerator``` must be held strongly and calls to ```prepare``` and ```perform``` can occur in many places of your app, those checks need to be implemented quite frequently.

That is where FeedbackController comes into play. It simplifies the calls, needed to perform haptic feedback. It eliminates the need for the developer to keep in mind where the types of feedback can be configured.<br>
In addition to that, it comes with easy to use extensions of ```UIViewController```. They make it possible to use feedback everywhere in the app by two simple method calls:
<BILD HIER>
```swift
@IBAction func impactMedium(_ sender: Any) {
    prepareFeedback(for: .impact(style: .medium))
    hapticFeedbackImpactOccured()
}
```

However, a call to ```prepareFeedback(for:)``` should be made as early as possible so that the Taptic Engine can be powered on. Please see the example project for further details.


If it makes live easier for you, feel free to use it. Otherwise it could provide a reference implementation for you.

### Usage
If you integrate FeedbackController using CocoaPods, you need to ```import FeedbackController``` first.

When you expect that a user interaction will take place in the next couple of seconds, call ```prepareFeedback(for:)```. In doing so, the Taptic Engine will be powered on and is ready for your feedback. *The timing is not as critical as might have guessed and it turned out that preparing the Taptic Engine in ```viewDidAppear(_:)``` is sufficient.* <br>
However, the type of feedback is determined by the call to ```prepareFeedback(for:)```.


Secondly, a feedback needs to be performed. To do so, just call
1. ```hapticFeedbackImpactOccured()``` for a impact feedback.
2. ```hapticFeedbackNotificationOccured(with:)``` for a notification feedback, specifying the type of said notification.
3. ```hapticFeedbackSelectionChanged()``` for a selection feedback.

When you are done with the feedback, call ```doneWithHapticFeedback()``` to allow the Taptic Engine going back to its idle state.

## Installation
#### CocoaPods
FeedbackController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FeedbackController'
```

#### Manually
You can also install it manually. All you need to do is to add [FeedbackController.swift](TODO) to your project.

## Author

Please also take a look at my [personal website](https://anerma.de/about), my [blog](https://anerma.de/blog) as well as my [Twitter](https://twitter.com/klaarname) account 🙂


## License

FeedbackController is available under the MIT license. See the LICENSE file for more info.
