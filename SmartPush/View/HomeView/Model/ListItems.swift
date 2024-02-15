//
//  ListItems.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/15/24.
//

import UIKit
import RealmSwift

//struct ListItem {
//	let title: String
//	let color: UIColor
//	let imageName: String
//	var count: Int
//}

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

	static func getFilteredData(enumCase: ListItems, datas: [PushModel]) -> [PushModel] {
		 switch enumCase {
		 case .today:
			  return datas.filter {
					let calendar = Calendar.current
					let itemDateComponents = calendar.dateComponents([.year, .month, .day], from: $0.deadline)
					let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())

					return itemDateComponents.year == currentDateComponents.year && itemDateComponents.month == currentDateComponents.month && itemDateComponents.day == currentDateComponents.day
			  }
		 case .will:
			  return datas.filter { $0.deadline > Date() }
		 case .all:
			  return datas
		 case .star:
			  return datas.filter { $0.stared }
		 case .complete:
			  return datas.filter { $0.complete }
		 }
	}
}
//ListItem(title: "오늘", color: UIColor.systemBlue, imageName: "calendar.circle.fill", count: 0),
//ListItem(title: "예정", color: UIColor.orange, imageName: "newspaper.circle.fill", count: 0),
//ListItem(title: "전체", color: UIColor.darkGray, imageName: "archivebox.circle.fill", count: 0),
//ListItem(title: "중요", color: UIColor.systemYellow, imageName: "flag.circle.fill", count: 0),
//ListItem(title: "완료", c
