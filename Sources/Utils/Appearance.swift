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
//	ID: BC53EFBC-7957-4DBE-A40F-3957EF74233F
//
//	Pkg: Steps
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import UIKit

struct Appearance {
	
	/// Apply appearance properties
	public static func apply() {
		
		typealias Key = NSAttributedString.Key
		
		// Global
		let window = UIWindow.appearance()
		window.backgroundColor = .black
		window.tintColor = .white
		
		// Navigation
		let navigationBarAppearace = UINavigationBar.appearance()
		
		navigationBarAppearace.prefersLargeTitles = false
		navigationBarAppearace.isTranslucent = false
		navigationBarAppearace.barTintColor = .black
		
		navigationBarAppearace.titleTextAttributes = [Key.foregroundColor: UIColor.white,
													  Key.font: UIFont.systemFont(ofSize: 14, weight: .black)]
		
		// Button
		let buttonAppearace = UIButton.appearance()
		buttonAppearace.setTitleColor(UIColor(named: "blueLabel"), for: .normal)
	}
}
