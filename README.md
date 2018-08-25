# TrendingGitHubProjects

## Project archicteture priciples

Application use MVVM-C Arhcitecture.

### Frameworks:
* Swinject - DI Container
* ReactiveSwift - Reactive framework
* ReactiveCocoa - UI bindings for ReactiveSwift

### Screens:
* GitHubTrends
* GitHubRepository

Any screen consist from View and ViewModel. 
* "View": implemented by UIViewController
* "ViewModel" implements business logic and provide observable properties for ability bind them to UI.
* "Coordinator" is component which encapsulate logic for forwarding between UI flows
* "Assebly" is component for dependecies between others components and setup DI
* "GitHubClient" is commont model component which encapsulate GitHub REST API
