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
//	ID: 82A820E5-E7BF-4815-B71D-BB58FD2A7C10
//
//	Pkg: Steps
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation
import CoreData

// MARK: - NSManagedObject
@objc(Badge)
class Badge: NSManagedObject, Codable {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Badge> {
		return NSFetchRequest<Badge>(entityName: "Badge")
	}
	
	@NSManaged public var steps: Int16
	@NSManaged public var name: String?
	@NSManaged public var isUnlocked: Bool
	
	//
	enum CodingKeys: String, CodingKey {
		case steps, name, isUnlocked
	}
	
	required convenience init(from decoder: Decoder) throws {
		guard let codingBadgeInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
			let managedObjectContext = decoder.userInfo[codingBadgeInfoKeyManagedObjectContext] as? NSManagedObjectContext,
			let entity = NSEntityDescription.entity(forEntityName: "Badge", in: managedObjectContext) else {
				fatalError("Failed to decode User")
		}
		
		self.init(entity: entity, insertInto: managedObjectContext)
		decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.steps = try container.decodeIfPresent(Int.self, forKey: .steps)
		self.name = try container.decodeIfPresent(String.self, forKey: .name)
		self.isUnlocked = try container.decodeIfPresent(Bool.self, forKey: .isUnlocked)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(steps, forKey: .steps)
		try container.encode(name, forKey: .name)
		try container.encode(isUnlocked, forKey: .isUnlocked)
	}
}
