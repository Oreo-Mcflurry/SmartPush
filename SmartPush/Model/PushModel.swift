//
//  PushModel.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import Foundation
import RealmSwift

class PushModel: Object {
	@Persisted var id = UUID()
	@Persisted var addDate = Date()
	@Persisted var complete: Bool = false
	@Persisted var stared: Bool = false
	@Persisted var title: String
	@Persisted var memo: String?
	@Persisted var deadline: Date
	@Persisted var category: String

	init(title: String, memo: String? = nil, deadline: Date, category: String) {
		self.title = title
		self.memo = memo
		self.deadline = deadline
		self.category = category
	}

	override init() {
		self.title = ""
		self.memo = ""
		self.deadline = Date()
		self.category = ""
	}
}

enum Categorys: String {
	case study
	case coding
	case game
}
