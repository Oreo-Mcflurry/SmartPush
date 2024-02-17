//
//  PushModel.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import Foundation
import RealmSwift

class PushModel: Object {
	@Persisted(primaryKey: true) var id = UUID()
	@Persisted var addDate = Date()
	@Persisted var complete: Bool = false
	@Persisted var stared: Bool = false
	@Persisted var title: String
	@Persisted var memo: String?
	@Persisted var deadline: Date
	@Persisted var category: String
	@Persisted var priority: Int

	init(title: String, memo: String? = nil, deadline: Date, category: String, priority: Int) {
		self.title = title
		self.memo = memo
		self.deadline = deadline
		self.category = category
		self.priority = priority
	}

	override init() {
		self.title = ""
		self.memo = ""
		self.deadline = Date()
		self.category = ""
		self.priority = 1
	}
}
