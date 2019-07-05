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
//	ID: B96B0FB4-5E56-4045-A4CB-3E4FC8F5C5CF
//
//	Pkg: Steps
//
//	Swift: 4.0 
//
//	MacOS: 10.15
//

import UIKit

class AchievementsEmpty: UIView {
	
	private lazy var image = UIImageView("no-steps")
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 24, weight: .heavy)
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.alpha = 0.5
		label.font = .systemFont(ofSize: 24, weight: .medium)
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
}

// MARK: - UI
extension AchievementsEmpty {
	
	private func setupView() {
		preservesSuperviewLayoutMargins = true
		addSubview(image)
		addSubview(titleLabel)
		addSubview(detailLabel)
		titleLabel.text = "No achievements yet"
		detailLabel.text = "Keep walking!"
		setupLayout()
	}
	
	private func setupLayout() {
		image.anchor(width: 116,
					 height: 116,
					 centerX: centerXAnchor,
					 centerY: centerYAnchor,
					 paddingCenterY: -63)
		
		titleLabel.anchor(top: image.bottomAnchor,
						  paddingTop: 5,
						  centerX: image.centerXAnchor)
		
		detailLabel.anchor(top: titleLabel.bottomAnchor,
						   centerX: image.centerXAnchor)
	}
}
