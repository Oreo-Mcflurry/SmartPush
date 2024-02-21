//
//  ChartViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/21/24.
//

import UIKit
import SnapKit
import RealmSwift
import DGCharts

class ChartViewController: BaseViewController {
	let chart = LineChartView()
	var datas: Results<PushModel>!
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureHierarchy() {
		view.addSubview(chart)
	}

	override func configureLayout() {
		chart.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			$0.height.equalTo(400)
		}
	}

	override func configureView() {
		datas = RealmManager().fetchData().sorted(byKeyPath: "deadlineDate", ascending: true)
		guard let first = datas.first, let last = datas.last else { return }
		var entry: [ChartDataEntry] = []
		let calendar = Calendar.current
		var currentDate = first.deadlineDate

		var currentIndex = 0
		while currentDate <= last.deadlineDate {
			let newData = ChartDataEntry(x: Double(currentIndex+1),
												  y: Double(RealmManager().fetchDataWithDate(date: currentDate).count))
			entry.append(newData)
			currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
			currentIndex += 1
		}
		let set = LineChartDataSet(entries: entry, label: "테스트")
		chart.data = LineChartData(dataSets: [set])


	}
}
