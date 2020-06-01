# SwiftyWeather
An app made with ❤️ to demonstrate some examples of **clean architecture**, **code organisation**, **loose coupling**, **unit testing** and some of the best practices used in modern iOS programming using latest `Swift 5.0.1` and its latest power tools like `Combine` and some of the `SwiftUI` magic.

## Clean Architecture
 - **VIPER** & **MVP** - A hybrid achitecture
 - Clean communication between **`Display`**, **`Presenter`** in the view/scene stack
 - Communication between  **`Interactor`**, **`Service`** in the lower stacks of domain & network layers
 - Connectivity of this components are achieved via protocol instances to achieve loose coupling and unit testability
 - `View` (i.e. View Controller) is `Display` itself and contacts its `Presenter`
 - `Presenter` may perform view related logic and immediately talk back to `Display` (e.g. list data source handling, image lading operation queues)
 - `Presenter` can communicate with underlying `Interactor` layer for more complex task
 - `Interactor` decides all Domain level business logic to take care of
 - `Interactor` communicates with underlying `Service` layer
 - `Service` communicates to its underlying **`HttpClient`** which handles all networking
 - `Interactor` gets back information via `Rx` binding from `Service`
 - `Interactor` parses the data and apply any necessary data transformation (eg. empty list of facts or subject name missing etc.)
 - `Interactor` gives outcome back to `Presenter` via callbacks
 - `Presenter` handles all the presentation reated logic nesessary for the view
 - `Presenter` uses a helper  **`Transformer`** that only cares about domain data to presentation item transformation needed for table cell UI binding
 - `Presenter` talks back to `Display` and commands UI update tasks
 - `Presenter` talks to `Router` for navigation tasks to go to a new screne/module


## Demos:

![](/Screenshots/demo-giphy.gif "")

### Light Mode
![](/Screenshots/light-shimmer.png "")
![](/Screenshots/light-list.png "")
![](/Screenshots/light-detail.png "")

### Dark Mode
![](/Screenshots/dark-list.png "")
![](/Screenshots/dark-detail.png "")


## Installation

- **Xcode 11.4**(required) with Swift 5.0
- For **convenience**  `Carthage/Checkouts` and `Carthage/Build` folders are checked in the repo. So if you are downloading/cloning this project, those are `ready` and `Xcode 11.4` should compile as long as `Swift 5.0` is available.
 - **Optional step**: Run the Carthage (version 0.33 or later) update command to `fresh install` the dependent libraries in the `Cartfile`
    > **`carthage update --platform iOS`** 
- Clean and build the project in Xcode or `/DerivedData` folder if needed

## 3rd Party Libraries Used
 - **`SnapKit`** - to snap auto layout constraints with ease 🤓 
 - **`SkeletonView`** - to show loading shimmers... 🙈 
 - **`Quick`** - to unit test as much as possible 👨🏽‍🔬🧪
 - **`Nimble`** - to pair with Quick for easy syntaxing 👬
 
 
# TODOs:
 - City search feature to add /remove new cities
 - Full Documentation
 - **Unit testing at each layer** (via `Quick / Nimble`)
 
