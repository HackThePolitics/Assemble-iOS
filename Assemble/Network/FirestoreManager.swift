//
//  FireStoreManager.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import FirebaseFirestore
import FirebaseCore

class FirestoreManager {

	static let shared = FirestoreManager()
	
	static func firestoreDB() -> Firestore {
		let db = Firestore.firestore()
		let settings = db.settings
		settings.areTimestampsInSnapshotsEnabled = true
		db.settings = settings
		return db
	}
	
	static func getProblems(successCompletion: @escaping (([Problem]) -> ())) {
		let ref = firestoreDB().collection("problems")
		ref.getDocuments() { querySnapshot, error in
			guard error == nil, let documents = querySnapshot?.documents else {
					ContextLogger.logServerError("Can't get problems. Error \(String(describing: error))")
				return
			}
			
			let problems = documents.compactMap { doc in
				return Problem(id: doc.documentID, dictionary: doc.data())
			}
			successCompletion(problems)
		}
	}
	


//	static func saveRestaurant() {
//		let collection = firestoreDB().collection("testrestaurants")
//		let restaurant = Restaurant(
//			name: "some name",
//			category: "home category",
//			city: "city ",
//			price: 123,
//			ratingCount: 0,
//			averageRating: 0
//		)
//		
//		collection.addDocument(data: restaurant.dictionary)
//	}
	
}
