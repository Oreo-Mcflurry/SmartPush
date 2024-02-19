//
//  RealmManager.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/17/24.
//

import UIKit
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

	// enum같은걸로 처리하고 싶은데 귀찮음 이슈로 미루겠습니다
	func saveImageToDocument(image: UIImage, withId id: String) {
		guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

		let fileUrl = documentDirectory.appendingPathComponent("\(id).jpeg")
		guard let data = image.jpegData(compressionQuality: 0.5) else { return }
		do {
			try data.write(to: fileUrl)
		} catch {
			print(error.localizedDescription)
		}
	}

	func deleteImageToDocument(withId id: String) {
		guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
		let fileUrl = documentDirectory.appendingPathComponent("\(id).jpeg")
		if FileManager.default.fileExists(atPath: fileUrl.path()) {
			do {
				try FileManager.default.removeItem(at: fileUrl)
			} catch {
				print(error.localizedDescription)
			}
		}
	}

	func loadImageToDocument(withId id: String) -> UIImage {
		guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star")! }
		let fileUrl = documentDirectory.appendingPathComponent("\(id).jpeg")
		if FileManager.default.fileExists(atPath: fileUrl.path()) {
			return UIImage(contentsOfFile: fileUrl.path())!
		}
		return UIImage(systemName: "star")!
	}

	func getTodoSign(withBool value: Bool) -> UIImage {
		return value ? UIImage(systemName: "circle.fill")! : UIImage(systemName: "circle")!
	}

	func getStarSign(withBool value: Bool) -> UIImage {
		return value ? UIImage(systemName: "star.fill")! : UIImage(systemName: "star")!
	}

	func getTitle(_ item: PushModel) -> String {
		switch item.priority {
		case 0:
			return "\(item.title)!!!"
		case 1:
			return "\(item.title)!!"
		case 2:
			return "\(item.title)!"
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

	func todoUpdate(_ id: UUID) {
		do {
			try realm.write {
				if let data = realm.object(ofType: PushModel.self, forPrimaryKey: id) {
					let value: [String: Any] = [
						"id": data.id,
						"complete": !data.complete
						]
					realm.create(PushModel.self, value: value, update: .modified)
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func starUpdate(_ id: UUID) {
		do {
			try realm.write {
				if let data = realm.object(ofType: PushModel.self, forPrimaryKey: id) {
					let value: [String: Any] = [
						"id": data.id,
						"stared": !data.stared
						]
					realm.create(PushModel.self, value: value, update: .modified)
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func fetchData() -> Results<PushModel> {
		return realm.objects(PushModel.self)
	}

	func fetchDataWithDate(date: Date) -> Results<PushModel> {
		let start = Calendar.current.startOfDay(for: date)
		let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
		let predicate = NSPredicate (format: "deadline >= %@ && deadline < %@",start as NSDate, end as NSDate)
		return realm.objects(PushModel.self).filter(predicate)
	}
}
