//
//  ProblemViewController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

class ProblemViewController: UIViewController {
	
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	
	private let problem: Problem
	
	private var solutionsCollection: LocalCollection<Solution>!
	
	init(problem: Problem) {
		self.problem = problem
		
		super.init(nibName: nil, bundle: nil)
		
		view.backgroundColor = .white
		let rightButton = UIBarButtonItem(title: "   ", style: .done, target: self, action: #selector(rightButtonTapped))
		navigationItem.rightBarButtonItem = rightButton
		
		functionalTableData.tableView = tableView
		view.addSubview(tableView)
		tableView.constrainEdges(to: view)
		
		solutionsCollection = LocalCollection<Solution>(
			query: FirestoreManager.firestoreDB()
				.collection("solutions")
				.whereField("problemId", isEqualTo: problem.id ?? ""),
			updateHandler: { [weak self] changed in
				ContextLogger.printContext("Changed solutions collection!")
				self?.render()
		})
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		solutionsCollection.listen()
	}
	
	deinit {
		solutionsCollection.stopListening()
	}
	
	private func tableSections() -> [TableSection] {
		var rows = [CellConfigType]()
		
		let titleCell = FTDCellFactory.headerCell(key: "titleCell", title: problem.title)
		rows.append(titleCell)
		
		let topSolutionsHeaderCell = FTDCellFactory.headerCell(key: "top solutions", title: "TOP SOLUTIONS")
		rows.append(topSolutionsHeaderCell)

		for solution in solutionsCollection.items {
			let headerCell = FTDCellFactory.headerCell(key: "header \(solution.id ?? "")", title: solution.title)
			rows.append(headerCell)
		}
		
		return [TableSection(key: "table", rows: rows)]
	}
	
	private func render() {
		functionalTableData.renderAndDiff(tableSections())
	}
	
	@objc private func rightButtonTapped() {
		let vc = AddSolutionsDataViewController(problemId: problem.id ?? "")
		navigationController?.show(vc, sender: nil)
	}
}
