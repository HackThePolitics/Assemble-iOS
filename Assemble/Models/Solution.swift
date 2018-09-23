//
//  Solution.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

struct Solution {
	
	var title: String
	var level: String
	
	var dictionary: [String: Any] {
		return [
			"title": title,
			"level": level
		]
	}
}

extension Solution: DocumentSerializable {
	init?(id: String, dictionary: [String : Any]) {
		guard let title = dictionary["title"] as? String,
			let level = dictionary["level"] as? String else { return nil }
		
		self.init(title: title,
				  level: level)
	}
	
}
