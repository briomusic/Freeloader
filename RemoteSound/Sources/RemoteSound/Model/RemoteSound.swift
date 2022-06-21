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
