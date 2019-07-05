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
//	ID: 20279F23-3DDC-4C3D-B89F-F92B5FCB4E03
//
//	Pkg: Steps
//
//	Swift: 4.0
//
//	MacOS: 10.15
//

import UIKit

class AchievementsStatsView: UIView {
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.font = .systemFont(ofSize: 24, weight: .bold)
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .right
		label.textColor = UIColor(named: "blueLabel")
		label.font = .systemFont(ofSize: 24, weight: .bold)
		return label
	}()
	
	private lazy var achievementsList = AchievementsListView()
	
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
extension AchievementsStatsView: Configurable {
	func configure(_ model: StepsViewModel) {
		titleLabel.text = model.achievementsTitleText
		detailLabel.text = model.achievementsCountText
		achievementsList.configure(model)
	}
}

// MARK: - UI
extension AchievementsStatsView {
	private func setupView() {
		preservesSuperviewLayoutMargins = true
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(achievementsList)
		setupLayout()
		
		// Debug
		debugMode()
		titleLabel.debugMode()
		detailLabel.debugMode()
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: topAnchor, left: leftAnchor)
		detailLabel.anchor(top: topAnchor, right: rightAnchor)
		achievementsList.anchor(top: titleLabel.bottomAnchor,
								left: titleLabel.leftAnchor,
								right: detailLabel.rightAnchor,
								height: 180)
	}
}

