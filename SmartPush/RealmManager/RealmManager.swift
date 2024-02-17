//
//  RealmManager.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/17/24.
//

import Foundation
import RealmSwift

class RealmManager {
	var realm: Realm {
		return try! Realm()
	}

	func getPriority(withPriority item: Int) -> String {
		switch item {
		case 0:
			return "상"
		case 1:
			return "중"
		case 2:
			return "하"
		default:
			return "알수없음"
		}
	}

	func getTitle(_ item: PushModel) -> String {
		switch item.priority {
		case 0:
			return "\(item.title)!"
		case 1:
			return "\(item.title)!!"
		case 2:
			return "\(item.title)!!!"
		default:
			return item.title
		}
	}

	func deleteAll() {
		do {
			try realm.write {
				realm.deleteAll()
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func deleteItem(_ item: PushModel) {
		do {
			try realm.write {
				if let data = realm.object(ofType: PushModel.self, forPrimaryKey: item.id) {
					realm.delete(data)
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func addItem(_ item: PushModel) {
		do {
			try realm.write {
				realm.add(item)
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func updateItem(_ item: PushModel) {
		do {
			try realm.write {
				let value: [String: Any] = [
					"id": item.id,
					"addDate": item.addDate,
					"complete": item.complete,
					"stared": item.stared,
					"title": item.title,
					"memo": item.memo ?? "",
					"deadline": item.deadline,
					"category": item.category,
					"priority": item.priority
				]
				realm.create(PushModel.self, value: value, update: .modified)
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func fetchData() -> Results<PushModel> {
		return realm.objects(PushModel.self)
	}
}
