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
//	ID: 96FA3EFA-20C8-4F83-B1D1-4F78A605D950
//
//	Pkg: Steps
//
//	Swift: 4.0 
//
//	MacOS: 10.15
//

import UIKit

class AchievementsItemView: UIView {

	private lazy var image = UIImageView("10k", rounded: true)
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 16, weight: .heavy)
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.alpha = 0.5
		label.font = UIFont(name: "SFCompactText-Semibold", size: 13)
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

// MARK: - Configurable
extension AchievementsItemView: Configurable {
	func configure(_ model: StepsViewModel) {
		titleLabel.text = model.achievementsGoalText
		detailLabel.text = "10k"
	}
}

// MARK: - UI
extension AchievementsItemView {
	private func setupView() {
		preservesSuperviewLayoutMargins = true
		addSubview(image)
		addSubview(titleLabel)
		addSubview(detailLabel)
		setupLayout()
	}
	
	private func setupLayout() {
		anchor(width: 116, height: 180)
		
		image.anchor(top: topAnchor,
					 left: leftAnchor,
					 right: rightAnchor,
					 width: 116,
					 height: 116)
		
		titleLabel.anchor(top: image.bottomAnchor,
						  paddingTop: 6,
						  left: image.leftAnchor,
						  right: image.rightAnchor,
						  centerX: image.centerXAnchor)
		
		detailLabel.anchor(top: titleLabel.bottomAnchor,
						   left: image.leftAnchor,
						   right: image.rightAnchor,
						   centerX: image.centerXAnchor)
	}
}