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


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		let viewController = EncapsulatedViewController()
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
		
		return true
	}
}
