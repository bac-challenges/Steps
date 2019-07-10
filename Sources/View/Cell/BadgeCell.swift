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
//	ID: 0A5C3EC0-8666-4C1F-A248-88C005F5A646
//
//	Pkg: Steps
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class BadgeCell: UITableViewCell {
	
	// UI
	private lazy var emptyView = BadgeEmptyView()
	private lazy var listView = BadgeListView()
	
	// Init
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
}

// MARK: - Configurable
extension BadgeCell: Configurable {
	func configure(_ model: StepsViewModel) {
		#warning("Animate on set achivements")
		listView.configure(model)
	}
}

// MARK: - UI
extension BadgeCell {
	private func setupView() {
		selectionStyle = .none
		backgroundColor = .black
		preservesSuperviewLayoutMargins = true
		#warning("Move children to BadgeComponents group")
		addSubview(emptyView)
		addSubview(listView)
		setupLayout()
	}
	
	private func setupLayout() {
		layoutMargins = UIEdgeInsets(top: layoutMargins.top,
									 left: 25,
									 bottom: layoutMargins.bottom,
									 right: 25)
		
		emptyView.anchor(top: layoutMarginsGuide.topAnchor,
						 bottom: layoutMarginsGuide.bottomAnchor,
						 left: layoutMarginsGuide.leftAnchor,
						 right: layoutMarginsGuide.rightAnchor)
		
		listView.anchor(top: layoutMarginsGuide.topAnchor,
						bottom: layoutMarginsGuide.bottomAnchor,
						left: leftAnchor,
						right: rightAnchor,
						height: 280)
	}
}
