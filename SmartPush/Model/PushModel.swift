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
	@Persisted var deadlineDate: Date
	@Persisted var category: Categorys?
	@Persisted var priority: Int

	init(title: String, memo: String? = nil, deadline: Date, category: Categorys?, priority: Int) {
		self.title = title
		self.memo = memo
		self.deadlineDate = deadline
		self.category = category
		self.priority = priority
	}

	override init() {
		self.title = ""
		self.memo = ""
		self.deadlineDate = Date()
		self.category = Categorys(category: "")
		self.priority = 1
	}
}

class Categorys: Object {
	@Persisted(primaryKey: true) var id = UUID()
	@Persisted var addDate = Date()
	@Persisted var category: String?
	@Persisted(originProperty: "category") var main: LinkingObjects<PushModel>

	convenience init(id: UUID? = nil, addDate: Date? = nil, category: String) {
		self.init()
		if let id, let addDate {
			self.id = id
			self.addDate = addDate
		}
		self.category = category
	}
}
