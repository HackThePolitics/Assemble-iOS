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
		
		title = "Problem"
		view.backgroundColor = .backgroundGray
		tableView.backgroundColor = .clear

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
		
		if solutionsCollection.items.count > 0 {
			let topSolutionsHeaderCell = FTDCellFactory.headerCell(key: "top solutions", title: "TOP SOLUTIONS")
			rows.append(topSolutionsHeaderCell)
		}

		for solution in solutionsCollection.items {
			var subtitle = [ControlText]()
			subtitle.append(ControlText(text: "\n\(solution.followers) Followers",
											font: .boldSystemFont(ofSize: 16),
											color: .darkGray))

//			subtitle.append(ControlText(text: "\n\(solution.description)",
//										font: .systemFont(ofSize: 9),
//										color: .darkGray))
			
			subtitle.append(ControlText(text: "\nOwner: \(solution.owner)",
										font: .systemFont(ofSize: 14),
										color: .darkGray))
			
			subtitle.append(ControlText(text: "\nCreated: \(solution.created)",
				font: UIFont.systemFont(ofSize: 14),
				color: .darkGray))

			let cell = SolutionSummaryCell(
				key: "solution cell \(solution.id ?? "")",
				style: FTDCellFactory.clearCellStyle(),
				actions: CellActions(selectionAction: { [weak self] _ in
					let vc = SolutionViewController(solution: solution)
					self?.navigationController?.show(vc, sender: nil)
					return .deselected
				}),
				state: SolutionSummaryState(title: solution.title,
											subtitleControlText: subtitle,
											govLevelColor: solution.level.displayColor,
											govLevelText: solution.level.displayString))
			rows.append(cell)
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
