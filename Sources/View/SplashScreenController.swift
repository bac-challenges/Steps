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
//	ID: 96A8521A-0D85-4DA0-B586-D6B4B31688E9
//
//	Pkg: Steps
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import UIKit

class SplashScreenController: UIViewController {

	// UI
	private lazy var titleLabel = UILabel("58033C81".localized("Steps"),
										  color: UIColor(named: "blueLabel"),
										  size: 48,
										  weight: .black,
										  alpha: 0)
	
	private lazy var spinner = UIActivityIndicatorView(style: .whiteLarge)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIView.animate(withDuration: 0.5) {
			self.titleLabel.alpha = 1
		}
		spinner.startAnimating()
	}
}

// MARK: - UI
extension  SplashScreenController {
	private func setupView() {
		view.addSubview(titleLabel)
		view.addSubview(spinner)
		setuoLayout()
	}
	
	private func setuoLayout() {
		titleLabel.anchor(centerX: view.centerXAnchor,
						  centerY: view.centerYAnchor, paddingCenterY: -60)
		
		spinner.anchor(bottom: view.bottomAnchor, paddingBottom: 40,
					   centerX: view.centerXAnchor)
	}
}
