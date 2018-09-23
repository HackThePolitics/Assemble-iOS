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
		
		
		FirestoreSolutionSampleDataSaver.saveBorderSolution(problemId: problemId)
		FirestoreSolutionSampleDataSaver.saveIllegalGunSolution(problemId: problemId)
		FirestoreSolutionSampleDataSaver.saveEmploymentSolution(problemId: problemId)
		FirestoreSolutionSampleDataSaver.saveAfterSchoolSolution(problemId: problemId)
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
}

struct FirestoreSolutionSampleDataSaver {
	
	static func saveBorderSolution(problemId: String) {
		let borderSolution = Solution(
			id: nil,
			problemId: problemId,
			title: "Increase border security to make sure illegal guns do not make it into Canada",
			description: "Border security will prevent anyone with a handgun from entering the country illegally",
			level: GovernmentLevel.federal,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Solution_bordersecurity_banner.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Solution_bordersecurity_square.jpg",
			upvotes: 1274,
			followers: 281,
			owner: "Paige Sun",
			created: "12 days ago")
		
		saveSolution(borderSolution, successCompletion: {
			
		})
	}
	
	static func saveIllegalGunSolution(problemId: String) {
		let borderSolution = Solution(
			id: nil,
			problemId: problemId,
			title: "Make hand guns illegal and put anyone with a gun in jail",
			description: "We are Canada, we should have hand guns at all.",
			level: GovernmentLevel.federal,
			bannerImageUrl: "https://s3.amazonaws.com/assemble-assets/Solution_gunsillegal_banner.jpg",
			squareImageUrl: "https://s3.amazonaws.com/assemble-assets/Solution_gunsillegal_square.jpg",
			upvotes: 22,
			followers: 12,
			owner: "Alfie Tham",
			created: "20 days ago")
		
		saveSolution(borderSolution, successCompletion: {
			
		})
	}
	
	static func saveEmploymentSolution(problemId: String) {
		let borderSolution = Solution(
			id: nil,
			problemId: problemId,
			title: "Create employment opportunities for people in gangs or at risk of joining a gang so they do not turn to guns and crime",
			description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
			level: GovernmentLevel.provincial,
			bannerImageUrl: "",
			squareImageUrl: "",
			upvotes: 2324,
			followers: 1232,
			owner: "Mathew Weeks",
			created: "23 days ago")
		
		saveSolution(borderSolution, successCompletion: {
			
		})
	}
	
	static func saveAfterSchoolSolution(problemId: String) {
		let borderSolution = Solution(
			id: nil,
			problemId: problemId,
			title: "Free before / after school programs for any kid in a priority neighbourhood who is at risk of joining a gang",
			description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
			level: GovernmentLevel.municipal,
			bannerImageUrl: "",
			squareImageUrl: "",
			upvotes: 23432,
			followers: 3889,
			owner: "Paige Sun",
			created: "4 months ago")
		
		saveSolution(borderSolution, successCompletion: {
			
		})
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

struct FirestoreTalkingPointSampleDataSaver {
	
	static func dontBringGuns(solutionId: String) {
		let talkingPoint = TalkingPoint(id: nil,
										solutionId: solutionId,
										  isPro: true,
										  text: "guns can’t be sold or brought into canada so they should not be so many of any at all on our streets",
										  upvotes: 122,
										  profileName: "Betty Zhang",
										  profileImageUrl: "https://media.licdn.com/dms/image/C4D03AQEhR8PLnpJJRA/profile-displayphoto-shrink_800_800/0?e=1543449600&v=beta&t=xUc8tRqY9PoAony9adUnREnx5OmhmhunassCtnGtE10")
		saveTalkingPoint(talkingPoint, successCompletion: {
			
		})
	}
	
	static func services(solutionId: String) {
		let talkingPoint = TalkingPoint(id: nil,
										solutionId: solutionId,
										isPro: true,
										text: "We need a place to provide the services offered by the city. ",
										upvotes: 2983,
										profileName: "Betty Zhang",
										profileImageUrl: "https://media.licdn.com/dms/image/C4D03AQEhR8PLnpJJRA/profile-displayphoto-shrink_800_800/0?e=1543449600&v=beta&t=xUc8tRqY9PoAony9adUnREnx5OmhmhunassCtnGtE10")
		saveTalkingPoint(talkingPoint, successCompletion: {
			
		})
	}
	
	static func crime(solutionId: String) {
		let talkingPoint = TalkingPoint(id: nil,
										solutionId: solutionId,
										isPro: true,
										text: "We need a place to provide the services offered by the city. ",
										upvotes: 2342,
										profileName: "Betty Zhang",
										profileImageUrl: "https://media.licdn.com/dms/image/C4D03AQEhR8PLnpJJRA/profile-displayphoto-shrink_800_800/0?e=1543449600&v=beta&t=xUc8tRqY9PoAony9adUnREnx5OmhmhunassCtnGtE10")
		saveTalkingPoint(talkingPoint, successCompletion: {
			
		})
	}
	
	static func court(solutionId: String) {
		let talkingPoint = TalkingPoint(id: nil,
										solutionId: solutionId,
										isPro: false,
										text: "more police and court time needed to arrest and convict people with guns and this is expensive",
										upvotes: 232,
										profileName: "James Lee",
										profileImageUrl: "https://media.licdn.com/dms/image/C4D03AQEhR8PLnpJJRA/profile-displayphoto-shrink_800_800/0?e=1543449600&v=beta&t=xUc8tRqY9PoAony9adUnREnx5OmhmhunassCtnGtE10")
		saveTalkingPoint(talkingPoint, successCompletion: {
			
		})
	}
	
	static func gangs(solutionId: String) {
		let talkingPoint = TalkingPoint(id: nil,
										solutionId: solutionId,
										isPro: false,
										text: "makings guns illegal is not really solving for why people join gangs (i.e. they need employment and security in their own lives)",
										upvotes: 922,
										profileName: "James Lee",
										profileImageUrl: "https://media.licdn.com/dms/image/C4D03AQEhR8PLnpJJRA/profile-displayphoto-shrink_800_800/0?e=1543449600&v=beta&t=xUc8tRqY9PoAony9adUnREnx5OmhmhunassCtnGtE10")
		saveTalkingPoint(talkingPoint, successCompletion: {
			
		})
	}
	
	static func government(solutionId: String) {
		let talkingPoint = TalkingPoint(id: nil,
										solutionId: solutionId,
										isPro: false,
										text: "making guns illegal means changing the laws which not every level of government would agree on",
										upvotes: 2232,
										profileName: "Alfie Tham",
										profileImageUrl: "https://media.licdn.com/dms/image/C4D03AQEhR8PLnpJJRA/profile-displayphoto-shrink_800_800/0?e=1543449600&v=beta&t=xUc8tRqY9PoAony9adUnREnx5OmhmhunassCtnGtE10")
		saveTalkingPoint(talkingPoint, successCompletion: {
			
		})
	}
	
	private static func saveTalkingPoint(_ talkingPoint: TalkingPoint,
									 successCompletion: (() -> Void)? = nil) {
		let collection = FirestoreManager.firestoreDB().collection("talking-points")
		collection.addDocument(data: talkingPoint.dictionary, completion: { error in
			if let error = error {
				ContextLogger.logServerError("Couldn't add document with name \(talkingPoint.text), \(error)")
			}
			
			ContextLogger.logSuccess("Saved \(talkingPoint.text)!")
			successCompletion?()
		})
	}
}
