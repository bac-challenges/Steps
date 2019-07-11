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
//	ID: D9E38171-94B3-48ED-A5DF-314FCF160022
//
//	Pkg: Steps
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation

public enum GenericDecoder: DecoderType {

	case json, plist
	
	func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
		switch self {
		case .json: return try JSONDecoder().decode(type, from: data)
		case .plist: return try PropertyListDecoder().decode(type, from: data)
		}
	}
	
	var fileType: String {
		switch self {
		case .json: return "json"
		case .plist: return "plist"
		}
	}
}

public struct FileManager {

	// Singleton
	public static let shared = FileManager()
	
	// Get sample data
	@discardableResult
	public func loadFile<T: Codable>(_ name: String, decoder: GenericDecoder = .json) -> T? {
	
		if let url = Bundle.main.url(forResource: name, withExtension: decoder.fileType) {
			do {
				let data = try Data(contentsOf: url)
				let response = try decoder.decode(T.self, from: data)
				return response
			} catch {
				print("error:\(error)")
			}
		}
		return nil
	}
	
	public func saveFile<T: Encodable>(value: T) {
		if let encodedData = try? PropertyListEncoder().encode(value) {
			let path = "Config.plist"
			let pathAsURL = URL(fileURLWithPath: path)
			do {
				try encodedData.write(to: pathAsURL)
			}
			catch {
				print("Failed to write JSON data: \(error.localizedDescription)")
			}
		}
	}
}
