### The point of this project

The point of this project is to **learn** some stuff, mainly how to use [CocoaPods](http://cocoapods.org/).
We're gonna build a [9GAG](http://9gag.com) client that only shows us 9 gags every hour, so we're not going to get caught in the time wasting vortex, but we'll still get hour healthy laughs.

### What's CocoaPods

> CocoaPods: The best way to manage library dependencies in Objective-C projects.

If you're familiar with Ruby on Rails, it's the same thing as [Bundler](http://gembundler.com/), or it's lame copy attempt for Symfony 2, [Composer](http://getcomposer.org/).

If you're not, and you haven't sorted it out from the quote above, CocoaPods is a tool that's let us manage our libraries and their dependencies in our Objective-C projects. This means:

1. No more wasted time downloading all the libraries the one we want to use depends on.
2. Smart and safe version management, specially when we're working on a project with other people, which is 99% of the time.

### What do we need

* Ruby! CocoaPods comes as a Ruby Gem. If you don't have it yet get it from [here](http://www.ruby-lang.org/en/downloads/)
* Xcode Command Lines Tools installed, why? See [here](https://github.com/CocoaPods/CocoaPods/issues/430)

### What's going to happen

We're going to use some third party libraries to build this tiny app, namely:

* [MBProgressHUD](https://github.com/jdg/MBProgressHUD) to show nice progress rings and don't give the user the impression the app is dead
* [Reachabiliy](https://github.com/tonymillion/Reachability) to check if there's internet connection
* [webrequest](https://github.com/nfarina/webrequest) because it doesn't have a _pod_, so we'll see what we can do about it. And because I'm too lazy to write my own web requests using the SDK.


