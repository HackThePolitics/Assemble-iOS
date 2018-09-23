//
//  FireStoreManager.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import FirebaseFirestore

class FirestoreManager {

	static let shared = FirestoreManager()
	
	static func firestoreDB() -> Firestore {
		let db = Firestore.firestore()
		let settings = db.settings
		settings.areTimestampsInSnapshotsEnabled = true
		db.settings = settings
		return db
	}
	
	
	
}
