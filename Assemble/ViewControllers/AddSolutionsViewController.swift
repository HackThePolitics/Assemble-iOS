//
//  AddSolutionsViewController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation
import SwiftyTables

class AddSolutionsDataViewController: UIViewController {
	
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	
	private let problemId: String
	
	init(problemId: String) {
		self.problemId = problemId
		super.init(nibName: nil, bundle: nil)
		
		title = "Store Data"
		
		view.backgroundColor = .white
		
		functionalTableData.tableView = tableView
		view.addSubview(tableView)
		tableView.constrainEdges(to: view)
		
		render()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func tableSections() -> [TableSection] {
		var rows = [CellConfigType]()
		
		rows.append(normalTextCell(key: "border", title: "border", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreSolutionSampleDataSaver.saveBorderSolution(problemId: strongSelf.problemId)
		}))
		
		rows.append(normalTextCell(key: "gun", title: "gun", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreSolutionSampleDataSaver.saveIllegalGunSolution(problemId: strongSelf.problemId)
		}))
		
		rows.append(normalTextCell(key: "employment", title: "employment", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreSolutionSampleDataSaver.saveEmploymentSolution(problemId: strongSelf.problemId)
		}))
		
		rows.append(normalTextCell(key: "after school", title: "after school program", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreSolutionSampleDataSaver.saveBorderSolution(problemId: strongSelf.problemId)
		}))
		
		return [TableSection(key: "table", rows: rows)]
	}
	
	private func render() {
		functionalTableData.renderAndDiff(tableSections())
	}
	
	private func normalTextCell(key: String, title: String, selectionAction: @escaping () -> Void) -> CellConfigType {
		return TitleHeaderCell(key: key,
							   actions: CellActions(selectionAction: { _ in
								selectionAction()
								return .deselected
							}),
							   state: TitleHeaderState(title: title, titleColor: UIColor.black, font: UIFont.systemFont(ofSize: 16)))
	}
}
