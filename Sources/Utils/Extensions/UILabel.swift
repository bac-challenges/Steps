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
//	ID: F7EAA21B-8AC3-4F02-990B-16A9F7313E39
//
//	Pkg: Steps
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

extension UILabel {
	
	#warning("Document")
	///
	public convenience init(_ text: String = "",
							color textColor: UIColor? = .white,
							alignment textAlignment: NSTextAlignment = .center,
							font: UIFont? = nil,
							size fontSize: CGFloat = 24,
							weight fontWeight: UIFont.Weight = .bold,
							lines numberOfLines: Int = 0,
							alpha: CGFloat = 1) {
		self.init()
		self.text = text
		self.textColor = textColor
		self.textAlignment = textAlignment
		self.font = font ?? .systemFont(ofSize: fontSize, weight: fontWeight)
		self.numberOfLines = numberOfLines
		
		#warning("Properties not working...")
		self.alpha = alpha
		self.sizeToFit()
	}
}
