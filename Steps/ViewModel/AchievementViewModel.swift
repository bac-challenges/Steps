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
//	ID: 685BB963-D174-43AA-80EF-989A7D58C2A1
//
//	Pkg: Steps
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

struct AchievementViewModel: GenericViewModel {
	
	var model: Achievement
	
	init(_ model: Achievement) {
		self.model = model
	}
}

// MARK: - String
extension AchievementViewModel {
	var achievementsGoalText: String {
		return "730BDAB5".localized(withComment: "Goal achievement")
	}
	
	var image: UIImage? {
		let image = UIImage(named: imageString)
		return model.isUnlocked ? image:image?.noir
	}
	
	var imageString: String {
		return "\(model.steps)k"
	}
	
	var steps: Int {
		return model.steps
	}
	
	var stepsString: String {
		return "\(model.steps)k"
	}
}
