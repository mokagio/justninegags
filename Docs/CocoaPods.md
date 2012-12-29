## CocoaPods

> The best way to manage library dependencies in Objective-C projects.

### 1. Install CocoaPods

Installing CocoaPods is as simple as installing all the other Ruby Gems, I shouldn't even writing this, as what's written in the [install section](http://cocoapods.org/#install) is more than enough, anyway:

    [sudo] gem install cocoapods
    
Once the installation is completed run:

    pod setup
    
This will, guess what, setup everything CocoaPods needs on your system. You should see an output like this

        Setting up CocoaPods master repo
        Cloning spec repo `master' from `https://github.com/CocoaPods/Specs.git' (branch `master')
        Setup completed (read-only access)
        
Done! :)

### 2. Using CocoaPods

Again, everything written on the [website](http://cocoapods.org/#get_started) is pretty straightforward.

Go in the root folder of your Objective-C project and create a file named `Podfile`, with whatever editor you like. We'll use this file to list all the libraries, _pods_, we need in the project. The JustNineGags `Podfile` content is:

    platform :ios
    pod 'MBProgressHUD', '~> 0.5'
    pod 'Reachability',  '~> 3.1.0'
    
### 2.1 Adding a Pod

As you can see adding a Pod is really easy, just go on [CocoaPods website](http://cocoapods.org), look for the it, and then add it to the `Podfile` using it's name and the version you need.

### 2.2 Installing the Pods

Right now we've told CocoaPods the Pods we need but they aren't yet in out project. So let's run

    pod install
    
This will download all the libraries we've asked for, and all their dependencies. Sweet!

The first time we run `pod install` something else will happen, a `Pod/` folder, a `Podfile.lock`, and a `YourProjectName.xcworkspace` will be created.

**Important!** From now on remember to open your project through the `YourProjectName.xcworkspace` file, otherwise the pods won't be loaded by Xcode.

That's all folks! :)