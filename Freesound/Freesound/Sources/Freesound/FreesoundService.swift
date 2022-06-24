//
//  File.swift
//  
//
//  Created by Brio Taliaferro on 15.06.22.
//

import Foundation
import RemoteSound

public class FreesoundService : RemoteSoundService {
	
	#warning("enter token")
	let token = ""

	public init() {
	}
		
	public func fetch(searchType: SearchType, query: String, maxDuration: Double, callback: @escaping (RemoteSoundList?, Error?) -> Void) {
		guard let url = URL(string: "https://www.freesound.org/apiv2/search/text/?query=\(query)&token=\(token)") else {
			callback(nil, RemoteSoundServiceError.invalidURL)
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
			if let error = error {
				callback(nil, error)
				return
			}
			
			guard let data = data else {
				callback(nil, RemoteSoundServiceError.noData)
				return
			}

			guard let self = self,
				  let list = try? JSONDecoder().decode(FreesoundList.self, from: data) else {
				callback(nil, RemoteSoundServiceError.parsingError)
				return
			}
			
			var sounds = [RemoteSound]()
	
			let serviceGroup = DispatchGroup()
			
			for listItem in list.results {
				serviceGroup.enter()
				self.addDetail(listItem: listItem) { detailItem, error in
					guard let detailItem = detailItem,
						  let sound = RemoteSound(detailItem: detailItem) else {
						serviceGroup.leave()
						return
					}
					
					sounds.append(sound)
					serviceGroup.leave()
				}
			}
			
			serviceGroup.notify(queue: DispatchQueue.main) {
				let soundList = RemoteSoundList(sounds: sounds)
				callback(soundList,nil)
			}
			
		}.resume()
	}
	

	func addDetail(listItem: FreesoundListItem, callback: @escaping (FreesoundDetailItem?, Error?) -> Void) {
		guard let url = URL(string: "https://www.freesound.org/apiv2/sounds/\(listItem.id)/?token=\(token)") else {
			callback(nil, RemoteSoundServiceError.invalidURL)
			return
		}

		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
			if let error = error {
				callback(nil, error)
				return
			}

			guard let data = data else {
				callback(nil, RemoteSoundServiceError.noData)
				return
			}

			guard let detailItem = try? JSONDecoder().decode(FreesoundDetailItem.self, from: data) else {
				callback(nil, RemoteSoundServiceError.parsingError)
				return
			}
			
			callback(detailItem, nil)
		}).resume()
	}

}
