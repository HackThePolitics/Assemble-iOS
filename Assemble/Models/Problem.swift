//
//  Problem.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

struct Problem {
	
	let id: String?
	let title: String
	let level: String
	let bannerImageUrl: String
	let squareImageUrl: String
	
	let followers: Int
	let owner: String
	let created: String

	var dictionary: [String: Any] {
		return [
			"title": title,
			"level": level,
			"bannerImageUrl": bannerImageUrl,
			"squareImageUrl": squareImageUrl,

			"followers": followers,
			"owner": owner,
			"created": created
		]
	}
}

extension Problem: DocumentSerializable {
	init?(id: String, dictionary: [String : Any]) {
		guard let title = dictionary["title"] as? String,
			let level = dictionary["level"] as? String,
			let bannerImageUrl = dictionary["bannerImageUrl"] as? String,
			let squareImageUrl = dictionary["squareImageUrl"] as? String,
			
			let followers = dictionary["followers"] as? Int,
			let owner = dictionary["owner"] as? String,
			let created = dictionary["created"] as? String else {
				return nil
		}
		
		self.init(id: id,
				  title: title,
				  level: level,
				  bannerImageUrl: bannerImageUrl,
				  squareImageUrl: squareImageUrl,
				  followers: followers,
				  owner: owner,
				  created: created)
	}
}
