//
//  LocalCollection.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import FirebaseFirestore

// A type that can be initialized from a Firestore document.
protocol DocumentSerializable {
	init?(id: String, dictionary: [String : Any])
}

final class LocalCollection<T: DocumentSerializable> {
	
	private(set) var items: [T]
	private(set) var documents: [DocumentSnapshot] = []
	let query: Query
	
	private let updateHandler: ([DocumentChange]) -> ()
	
	private var listener: ListenerRegistration? {
		didSet {
			oldValue?.remove()
		}
	}
	
	var count: Int {
		return self.items.count
	}
	
	subscript(index: Int) -> T {
		return self.items[index]
	}
	
	init(query: Query, updateHandler: @escaping ([DocumentChange]) -> ()) {
		self.items = []
		self.query = query
		self.updateHandler = updateHandler
	}
	
	func index(of document: DocumentSnapshot) -> Int? {
		for i in 0 ..< documents.count {
			if documents[i].documentID == document.documentID {
				return i
			}
		}
		
		return nil
	}
	
	func listen() {
		guard listener == nil else { return }
		listener = query.addSnapshotListener { [unowned self] querySnapshot, error in
			guard let snapshot = querySnapshot else {
				print("Error fetching snapshot results: \(error!)")
				return
			}
			let models = snapshot.documents.map { document -> T in
				
				if let model = T(id: document.documentID, dictionary: document.data()) {
					return model
				} else {
					// handle error
					fatalError("Unable to initialize type \(T.self) with dictionary \(document.data())")
				}
			}
			self.items = models
			self.documents = snapshot.documents
			self.updateHandler(snapshot.documentChanges)
		}
	}
	
	func stopListening() {
		listener = nil
	}
	
	deinit {
		stopListening()
	}
}
