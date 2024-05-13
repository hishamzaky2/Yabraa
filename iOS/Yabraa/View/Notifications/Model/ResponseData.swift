/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ResponseData : Codable {
	let id : Int?
	let exception : String?
	let status : Int?
	let isCanceled : Bool?
	let isCompleted : Bool?
	let isCompletedSuccessfully : Bool?
	let creationOptions : Int?
	let asyncState : String?
	let isFaulted : Bool?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case exception = "exception"
		case status = "status"
		case isCanceled = "isCanceled"
		case isCompleted = "isCompleted"
		case isCompletedSuccessfully = "isCompletedSuccessfully"
		case creationOptions = "creationOptions"
		case asyncState = "asyncState"
		case isFaulted = "isFaulted"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		exception = try values.decodeIfPresent(String.self, forKey: .exception)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		isCanceled = try values.decodeIfPresent(Bool.self, forKey: .isCanceled)
		isCompleted = try values.decodeIfPresent(Bool.self, forKey: .isCompleted)
		isCompletedSuccessfully = try values.decodeIfPresent(Bool.self, forKey: .isCompletedSuccessfully)
		creationOptions = try values.decodeIfPresent(Int.self, forKey: .creationOptions)
		asyncState = try values.decodeIfPresent(String.self, forKey: .asyncState)
		isFaulted = try values.decodeIfPresent(Bool.self, forKey: .isFaulted)
	}

}