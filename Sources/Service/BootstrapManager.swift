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
//	ID: 4FCAC0BE-DD3C-408D-92E9-3CC52D04C378
//
//	Pkg: Steps
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import Foundation

struct BootstrapManager {
	
	// Shared instance
	public static let shared = BootstrapManager()
	
	// Configure app
	func preflight(completion: @escaping (Bool) -> Void) {
		
		guard let settings = settings else {
			fatalError("Loading configuration failed")
		}
		
		// Beging configuration
		if !settings.isPreflightComplete {
			print("Start onboarding")
		}
		
		completion(true)
	}
	
	// App settings
	private var settings: Settigns? {
		
		// Load settings from bundle
		get {
			return FileManager.shared.loadFile("Config", decoder: .plist)
		}
		
		// Save settings in bundle
		set {
			
		}
	}
}

// Settings
private struct Settigns: Codable {
	let isPreflightComplete: Bool
//	let achievements: [Any]
}
