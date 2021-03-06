//
//  AddDataViewController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

class AddProblemDataViewController: UIViewController {
	
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	
	init() {
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
		
		rows.append(normalTextCell(key: "add gun problem", title: "gun", selectionAction: {
			print("***********")
			FirestoreSampleDataSaver.storeGunProblem()
		}))
		
		rows.append(normalTextCell(key: "add motorists problem", title: "motorists", selectionAction: {
			FirestoreSampleDataSaver.storeMotoristsProblem()
		}))
		
		rows.append(normalTextCell(key: "store homeless problem", title: "homelessness", selectionAction: {
			FirestoreSampleDataSaver.storeHomelessProblem()
		}))
		
		rows.append(normalTextCell(key: "add school problem", title: "school", selectionAction: {
			FirestoreSampleDataSaver.storeSchoolProblem()
		}))
		
		rows.append(normalTextCell(key: "add housing problem", title: "housing", selectionAction: {
			FirestoreSampleDataSaver.storeHousingProblem()
		}))
		
		rows.append(normalTextCell(key: "add opioid problem", title: "opioid", selectionAction: {
			FirestoreSampleDataSaver.storeOpioidProblem()
		}))
		
		rows.append(normalTextCell(key: "add pollution problem", title: "pollution", selectionAction: {
			FirestoreSampleDataSaver.storePollutionsProblem()
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
