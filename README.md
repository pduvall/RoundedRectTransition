# RoundedRectTransition
Custom view controller transition, written in Swift. Animates a modal presentation expanding from and collapsing into a sender frame, such as a UIButton

# Usage
```swift
// Instantiate the rounded rect transition delegate
// (retain this! the presented view controller will NOT retain its transitioning delegate)
    
let transitionDelegate = RoundedRectTransitionDelegate()
    
// (optional) Set a sender frame for the transition delegate
// if provided, the presented view controller will expand out of the sender frame 
// and collapse back into it on modal dismissal.
// if not provided, the presented view controller will expand from and collapse into
// the center of the presenting view controller
    
transitionDelegate.senderFrame = button.frame
    
// Set the transitioning delegate for the view controller that will be presented

let viewController = UIViewController()
viewController.transitioningDelegate = transitionDelegate
        
present(viewController, animated: true, completion: nil)
```

# Customization

A small amount of customization is possible by changing the values within the RoundedRectConstants struct. This allows for customization of parameters such as the duration of the animations and the corner radius of the rounded rectangle mask.
