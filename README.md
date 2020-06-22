# Swift - PopUp

Show popup with your custom view (can be used as notice or loading screen)

## How to use

Simple

```swift
let popUpView = UIView()
//Auto Layout
popUpView.translatesAutoresizingMaskIntoConstraints = false
popUpView.widthAnchor.constraint(equalToConstant: 100).isActive = true
popUpView.heightAnchor.constraint(equalToConstant: 100).isActive = true

//Setup
let popUpManager = PopUp(view: popUpView, backgroundColor: UIColor.black.withAlphaComponent(0.3))

popUpManager.showPopUp()
```
