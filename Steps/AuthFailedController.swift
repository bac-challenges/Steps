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
//	ID: 4E7219B2-2EC7-4E41-932C-7F3E7A173704
//
//	Pkg: Steps
//
//	Swift: 4.2
//
//	MacOS: 10.15
//

import UIKit

class AuthFailedController: UIViewController {

	// Model
	private lazy var model = StepsViewModel()
	
	// UI
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.text = model.authFailedTitleText
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 18, weight: .heavy)
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.text = model.authFailedDetailText
		label.alpha = 0.5
		label.font = .systemFont(ofSize: 14, weight: .medium)
		return label
	}()
	
	private lazy var button: UIButton = {
		let button = UIButton()
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.white.cgColor
		button.setTitle(model.authFailedButtonTitleText, for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(openHealthApp), for: .touchUpInside)
		return button
	}()
	
	private lazy var iconView: UIImageView = {
		let imageView = UIImageView("heart")
		imageView.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
		return imageView
	}()
	
	// Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
}

// MARK: - Actions
extension AuthFailedController {
	@objc func openHealthApp() {
		guard let settingsUrl = URL(string: "x-apple-health://") else {
			return
		}
		
		if UIApplication.shared.canOpenURL(settingsUrl) {
			UIApplication.shared.open(settingsUrl) { success in
				print("Settings opened: \(success)")
			}
		}
	}
}

// MARK: - UI
extension AuthFailedController {
	func setupView() {
		view.addSubview(titleLabel)
		view.addSubview(detailLabel)
		view.addSubview(button)
		view.addSubview(iconView)
		
		titleLabel.anchor(centerX: view.centerXAnchor,
						  centerY: view.centerYAnchor,
						  paddingCenterY: -80)
		
		detailLabel.anchor(top: titleLabel.bottomAnchor,
						   paddingTop: 5,
						   centerX: view.centerXAnchor)
		
		button.anchor(bottom: view.bottomAnchor,
					  paddingBottom: 40,
					  left: detailLabel.leftAnchor,
					  right: detailLabel.rightAnchor)
		
		iconView.anchor(bottom: titleLabel.topAnchor,
						right: titleLabel.rightAnchor,
						paddingRight: -13,
						width: 30,
						height: 30)
	}
}
