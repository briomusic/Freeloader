import Foundation
import UIKit

public struct RemoteSound: Hashable {
	
	let serviceId: Int
	let name: String

	let type: String // wav, etc
	let filesize: Int
	let downloadURL: URL
	let previewURL: URL
	let waveformURL: URL
	
	let id = UUID()
		
	public init(serviceId: Int, name: String, type: String, filesize: Int, downloadURL: URL, previewURL: URL, waveformURL: URL) {
		self.serviceId = serviceId
		self.name = name
		self.type = type
		self.filesize = filesize
		self.downloadURL = downloadURL
		self.previewURL = previewURL
		self.waveformURL = waveformURL
	}
}

extension UIColor {
	
	static let csOrange = UIColor(red: 1, green: 0.8, blue: 0.32, alpha: 1)
	static let csRed = UIColor(red: 1, green: 0.32, blue: 0.24, alpha: 1)
	
}


