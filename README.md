# HEB

This app demonstrates some interesting patterns with regards to dependency injection and code structure.  The primary pattern used is MVVM with RxSwift.  The app is simple and the UX is crude, but it was written quickly as an exercise.  The pattern used for Dependency Injection combines some POP and utilizing structs with static properties in order to create various implementations for a dependency.  The dependency graph itself is a simple class which is kept alive by the view controllers that reference it. The graph conforms to a composition of protocols which allows for a single dependency graph object to be injected into view controllers and gives us a nice compile-time check for safety.  

The ApiService and Logger are written as concrete structs instead of protocols.  This technique was brought to my attention via https://pointfree.co.  They provide an amazing amount of outstanding knowledge and patterns.  This alleviates the need for protocols and the boilerplate that often accompanies them.  Mocks are simple to write as they are just another instance of the struct provided in an extension.  Combined with RxSwift, it was very easy for me to write unit tests for all of the view model code with very little need for complex mocks and fakes.

The app home screen is made up of a table view which has a static set of rows.  The first being a cell containing a horizontally scrolling collection view which shows the band members and small bios.  The images are not being cached due to time constraints for this project, but they do come down and show up.  The Second cell is selectable and brings the user to the song list.  All of the data is live and not faked.

The structure of the code is using a pattern that I learned from one of the RxSwift experts on the RxSwift slack channel.  The view controllers are dumb, and all logic is handled in the "view model", while binding is done in an extension on the view controller.  The view model is simply a free floating function which can be considered the "logic" piece.  This alleviates boilerplate and makes testing much easier.  There is also very little mutable state.  Admittedly, when I was first introduced to this pattern I was a little hesitant since a free function seemed strange.  It shouldn't because it's not much different from a protocol or struct.  They're just functions and this is no different.  The view model itself, even if wrapped in a class or struct should simply be a function that takes input, transforms and emits an output. 

Unit tests were included for the view model but no UI tests were written.  I wrote a few protocol extensions for convenience that I commonly use. I have put comments throughout the code explaining some of my thoughts as well. 

I hope this is sufficient for this exercise and thank you to HEB for giving me this opportunity.

[Update] 10/16/2020
One of the things I touched upon in the comments in the code was the use of the Factory pattern to create view controllers to create less coupling between view controllers.  Without using a separate router or coordinator, there is less flexibility to navigate freely or to provide different ways of presenting the same routing path.  However, for less complex apps, this may not be needed and using a factory is at least a better way of allowing a view controller to not know about the implementation details of a view controller it may route too.

The way this would work would be a protocol defined:

````
typealias MyDependencies = HasApiService & HasLogger

protocol MyViewControllerFactory {
  func makeSongListViewController(dependencies: MyDependencies) -> UIViewController
}

The DependencyContainer class can now conform to this protocol and when it instantiates the new view controller, it can simply pass in self.

extension DependencyContainer: MyViewControllerFactory {
  func makeSongListViewControllerFactory(dependencies: MyDependencies) -> UIViewController {
      SongListViewController(dependencies: self)
  }
}
````
Now let's say we get a route message back from the view model that corresponds to this view controller we 
would simply create it and push it onto the stack.  While the view controller we are navigating FROM still 
has knowledge of the view controller it's navigating to, we can now more easily test this since our 
test DependencyContainer can implement the factory however we want, and we can verify that the 
proper factory method is invoked prior to the routing.
````
outputs.route
  .drive(onNext: { [weak self, dependencies] in
    let vc = dependencies.makeSongListViewController(dependencies: dependencies)
    self?.navigationController.pushViewController(vc, animated: true)
  })
  .disposed(by: bag)
````
It would also be feasible to provide a defined enum type representing the types of view controllers to create and a single factory function would be sufficient.

