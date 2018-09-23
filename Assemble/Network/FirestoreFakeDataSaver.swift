//
//  FirestoreSampleDataSaver.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

struct FirestoreSampleDataSaver {
	static func storeGunProblem() {
		let problem = Problem(
			id: nil,
			title: "Gun violence is on the rise in toronto",
			level: GovernmentLevel.provincial.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/gun_violence.png",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_gunviolence_square.jpg",
			followers: 98902,
			owner: "Paige Sun",
			created: "28 days ago")
		
		let problemId = saveProblem(problem, successCompletion: {
		})
		
		saveBorderSolution(problemId: problemId)
	}

	
	static func storeMotoristsProblem() {
		let problem = Problem(
			id: "motorisId",
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
			title: "Foam pollution seen on Mondays near the river",
			level: GovernmentLevel.provincial.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_pollution_square.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Problem_pollution_square.jpg",
			followers: 872,
			owner: "Paige Sun",
			created: "8 months ago")
		saveProblem(problem)
	}
	
	private static func saveProblem(_ problem: Problem,
									successCompletion: (() -> Void)? = nil) -> String {
		let collection = FirestoreManager.firestoreDB().collection("problems")
		return collection.addDocument(data: problem.dictionary, completion: { error in
			if let error = error {
				ContextLogger.logServerError("Couldn't add document with name \(problem.title), \(error)")
			}
			
			ContextLogger.logSuccess("Saved \(problem.title)!")
			successCompletion?()
		}).documentID
	}
	
	private static func saveSolution(_ solution: Solution,
									 successCompletion: (() -> Void)? = nil) {
		let collection = FirestoreManager.firestoreDB().collection("solutions")
		collection.addDocument(data: solution.dictionary, completion: { error in
			if let error = error {
				ContextLogger.logServerError("Couldn't add document with name \(solution.title), \(error)")
			}
			
			ContextLogger.logSuccess("Saved \(solution.title)!")
			successCompletion?()
		})
	}
}

extension FirestoreSampleDataSaver {
	
	private static func saveBorderSolution(problemId: String) {
		let borderSolution = Solution(
			id: nil,
			problemId: problemId,
			title: "Incraese border security",
			description: "Gun violence is on the rise in toronto",
			level: GovernmentLevel.provincial.displayString,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Solution_bordersecurity_banner.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Solution_bordersecurity_square.jpg",
			upvotes: 1274,
			followers: 281,
			owner: "Jie Lin",
			created: "20 days ago")
		
		saveSolution(borderSolution, successCompletion: {
			
		})
	}
}
