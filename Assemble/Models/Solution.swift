//
//  Solution.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

struct Solution {
	
	let id: String?
	let problemId: String
	let title: String
	let description: String
	let level: GovernmentLevel
	let bannerImageUrl: String
	let squareImageUrl: String
	
	let upvotes: Int
	let followers: Int
	let owner: String
	let created: String
	
	var dictionary: [String: Any] {
		return [
			"problemId": problemId,
			"title": title,
			"description": description,
			"level": level.displayString,
			"bannerImageUrl": bannerImageUrl,
			"squareImageUrl": squareImageUrl,
			
			"upvotes": upvotes,
			"followers": followers,
			"owner": owner,
			"created": created
		]
	}
}

extension Solution: DocumentSerializable {
	init?(id: String, dictionary: [String : Any]) {
		guard let title = dictionary["title"] as? String,
			let problemId = dictionary["problemId"] as? String,
			let description = dictionary["description"] as? String,
			let levelString = dictionary["level"] as? String,
			let level = GovernmentLevel(from: levelString),
			let bannerImageUrl = dictionary["bannerImageUrl"] as? String,
			let squareImageUrl = dictionary["squareImageUrl"] as? String,

			let upvotes = dictionary["upvotes"] as? Int,
			let followers = dictionary["followers"] as? Int,
			let owner = dictionary["owner"] as? String,
			let created = dictionary["created"] as? String else {
				return nil
		}
		
		self.init(id: id,
				  problemId: problemId,
				  title: title,
				  description: description,
				  level: level,
				  bannerImageUrl: bannerImageUrl,
				  squareImageUrl: squareImageUrl,
				  upvotes: upvotes,
				  followers: followers,
				  owner: owner,
				  created: created)
	}
	
}
