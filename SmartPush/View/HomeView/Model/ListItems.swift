//
//  ListItems.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/15/24.
//

import UIKit
import RealmSwift

enum ListItems: String, CaseIterable {
	case today = "오늘"
	case will = "예정"
	case all = "전체"
	case star = "중요"
	case complete = "완료"

	var getColor: UIColor {
		switch self {
		case .today:
			return UIColor.systemBlue
		case .will:
			return UIColor.orange
		case .all:
			return UIColor.darkGray
		case .star:
			return UIColor.systemYellow
		case .complete:
			return UIColor.darkGray
		}
	}

	var getImageName: String {
		switch self {
		case .today:
			return "calendar.circle.fill"
		case .will:
			return "newspaper.circle.fill"
		case .all:
			return "archivebox.circle.fill"
		case .star:
			return "flag.circle.fill"
		case .complete:
			return "checkmark.circle.fill"
		}
	}

	static func getFilteredData(enumCase: ListItems, datas: Results<PushModel>) -> Results<PushModel> {
		switch enumCase {
		case .today:
			let filteredArray = datas.where {
//					let calendar = Calendar.current
//				let itemDateComponents = calendar.dateComponents([.year, .month, .day], from: $0.deadline)
//					let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
//					return itemDateComponents.year == currentDateComponents.year && itemDateComponents.month == currentDateComponents.month && itemDateComponents.day == currentDateComponents.day
				let calendar = Calendar.current
				let start = calendar.startOfDay(for: Date())
				let end = calendar.date(byAdding: DateComponents(day: 1), to: start)
				return  $0.deadline >= start && $0.deadline < end!
			}
			return filteredArray

		case .will:
			return datas.where { $0.deadline > Date() }
		case .all:
			return datas
		case .star:
			return datas.where { $0.stared }
		case .complete:
			return datas.where { $0.complete }
		}
	}
}

//struct ListItem {
//	let title: String
//	let color: UIColor
//	let imageName: String
//	var count: Int
//}
