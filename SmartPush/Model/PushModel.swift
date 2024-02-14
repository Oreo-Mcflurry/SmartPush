//
//  PushModel.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import Foundation

struct PushModel {
	var id = UUID()
	var title: String
	var date: [DayofWeek]
	var bodyContent: [String]

	enum DayofWeek {
		 case monday
		 case tuesday
		 case wednesday
		 case thursday
		 case friday
		 case saturday
		 case sunday
	}
}
