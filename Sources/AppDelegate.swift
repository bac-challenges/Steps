//	MIT License
//
//	Copyright © 2019 Emile, Blue Ant Corp
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//
//	ID: F18C0B31-3853-4CFD-BBAF-94B079427762
//
//	Pkg: Steps
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		// Create window
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.makeKeyAndVisible()
		self.window?.rootViewController = SplashScreenController()
		
		// Appearance
		Appearance.apply()
		
		#warning("Use State Machine")
		// Configure Application
		BootstrapManager.shared.preflight { success in
			HealthKitManager.shared.isHealthDataAvailable { success, error in
				DispatchQueue.main.sync {
					let rootViewController = success ? StepsController() : AuthFailedController()
					self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
				}
			}
		}
		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		CoreDataManager.shared.saveContext()
	}
}

