//
//  File.swift
//  
//
//  Created by Brio Taliaferro on 08.06.22.
//

import Foundation
import RemoteSound


struct FreesoundList: Codable {
	var results: [FreesoundListItem]
}

struct FreesoundListItem: Codable {
	let id: Int
	let name: String
}


struct FreesoundDetailItem: Codable {
	let id: Int
	let name: String

	let type: String // wav, etc
	let filesize: Int
	let duration: Double
	let downloadURL: String
	let previews: Dictionary<String,String>
	let images: Dictionary<String,String>
	
	func previewURL() -> URL? {
		guard let preview = previews["preview-hq-mp3"] else {return nil}
		return URL(string: preview)
	}
	
	func waveformURL() -> URL? {
		guard let waveform = images["waveform_l"] else {return nil}
		return URL(string: waveform)
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case type // wav, etc
		case filesize
		case duration
		case downloadURL = "download"
		case previews
		case images
	}
}

extension RemoteSound {
	init?(listItem: FreesoundListItem) {
		self.init(serviceId: listItem.id,
				  name: listItem.name,
				  type: "",
				  filesize: 0,
				  downloadURL: URL(string: "http://google.com")!,
				  previewURL: URL(string: "http://google.com")!,
				  waveformURL: URL(string: "http://google.com")!)
	}

	init?(detailItem: FreesoundDetailItem) {
		self.init(serviceId: detailItem.id,
				  name: detailItem.name,
				  type: detailItem.type,
				  filesize: detailItem.filesize,
				  downloadURL: URL(string: detailItem.downloadURL)!,
				  previewURL: detailItem.previewURL()!,
				  waveformURL: detailItem.waveformURL()!)
	}

}
