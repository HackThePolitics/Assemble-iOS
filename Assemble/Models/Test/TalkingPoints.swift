//
//  TalkingPoints.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

struct TalkingPoint {
	
	let id: String?
	let solutionId: String
	let isPro: Bool
	let text: String
	
	let upvotes: Int
	let profileName: String
	let profileImageUrl: String
	
	var dictionary: [String: Any] {
		return [
			"solutionId": solutionId,
			"isPro": isPro,
			"text": text,
			"upvotes": upvotes,
			"profileName": profileName,
			"profileImageUrl": profileImageUrl,
		]
	}
}

extension TalkingPoint: DocumentSerializable {
	init?(id: String, dictionary: [String : Any]) {
		guard let solutionId = dictionary["solutionId"] as? String,
			let text = dictionary["text"] as? String,
			let isPro = dictionary["isPro"] as? Bool,
			let upvotes = dictionary["upvotes"] as? Int,
			let profileName = dictionary["profileName"] as? String,
			let profileImageUrl = dictionary["profileImageUrl"] as? String else {
				return nil
		}
		
		self.init(id: id,
				  solutionId: solutionId,
				  isPro: isPro,
				  text: text,
				  upvotes: upvotes,
				  profileName: profileName,
				  profileImageUrl: profileImageUrl)
	}
	
}
