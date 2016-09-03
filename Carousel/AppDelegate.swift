//
//  AppDelegate.swift
//  Carousel
//
//  Created by Benjamin Emdon on 2016-09-01.
//  Copyright © 2016 Benjamin Emdon.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		let viewController = ViewController()
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
		
		return true
	}
}
