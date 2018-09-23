//
//  FirestoreFakeDataSaver.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

struct FirestoreFakeDataSaver {
	static func storeGunProblem() {
		let problem = Problem(
			id: nil,
			title: "Gun violence is on the rise in toronto",
			level: GovernmentLevel.provincial.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/gun_violence.png",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_gunviolence_square.jpg",
			followers: 98902,
			owner: "Paige Sun",
			created: "18 days ago")
		saveProblem(problem)
	}
	
	static func storeMotoristsProblem() {
		let problem = Problem(
			id: nil,
			title: "Cyclists accidents by motorists",
			level: GovernmentLevel.municipal.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_cycling_banner.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_cycling_square.jpg",
			followers: 12311,
			owner: "Alfie Tham",
			created: "92 days ago")
		saveProblem(problem)
	}
	
	static func storeHomelessProblem() {
		let problem = Problem(
			id: nil,
			title: "Homeless youth have trouble finding resources",
			level: GovernmentLevel.municipal.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_homelessness_square.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_homelessness_square.jpg",
			followers: 3124,
			owner: "Leila Tisdall",
			created: "6 months ago")
		saveProblem(problem)
	}
	
	static func storeSchoolProblem() {
		let problem = Problem(
			id: nil,
			title: "Cars not slowing down near school at Beverly and Baldwin",
			level: GovernmentLevel.municipal.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_schoolcrossings_square.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_schoolcrossings_square.jpg",
			followers: 231,
			owner: "Jane Motz Hayes",
			created: "23 days ago")
		saveProblem(problem)
	}
	
	static func storeHousingProblem() {
		let problem = Problem(
			id: nil,
			title: "Rising housing and living costs",
			level: GovernmentLevel.municipal.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_risinghousing_square.jpeg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_risinghousing_square.jpeg",
			followers: 82912,
			owner: "Leila Tisdall",
			created: "3 months ago")
		saveProblem(problem)
	}

	static func storeOpioidProblem() {
		let problem = Problem(
			id: nil,
			title: "Spotted used needles near Trinity Park",
			level: GovernmentLevel.provincial.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_opoid_square.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_opoid_square.jpg",
			followers: 1982,
			owner: "Gavin Goh",
			created: "12 days ago")
		saveProblem(problem)
	}

	static func storePollutionsProblem() {
		let problem = Problem(
			id: nil,
			title: "Foam populution seen on Mondays and Wednesdays near the river",
			level: GovernmentLevel.provincial.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_pollution_square.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_pollution_square.jpg",
			followers: 872,
			owner: "Paige Sun",
			created: "8 months ago")
		saveProblem(problem)
	}
	
	
	private static func saveProblem(_ problem: Problem) {
		let collection = FirestoreManager.firestoreDB().collection("problems")
		collection.addDocument(data: problem.dictionary) { (error) in
			if let error = error {
				ContextLogger.logServerError("Couldn't add document with name \(problem.title), \(error)")
			}
			
			ContextLogger.logSuccess("Saved \(problem.title)!")
		}
	}
}
