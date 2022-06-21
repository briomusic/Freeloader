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

public extension UIImage {
	func pass() -> UIImage {
		return self
	}
	
	func convert(color: UIColor) -> UIImage {
		var contextRect = CGRect(x: 0, y: 0, width: self.size.width, height:self.size.height)
		
		// Retrieve source image and begin image context

		UIGraphicsBeginImageContextWithOptions(contextRect.size, false, 1)
		guard let context = UIGraphicsGetCurrentContext() else {return self}

		// Setup shadow
		// Setup transparency layer and clip to mask
		context.beginTransparencyLayer(auxiliaryInfo: nil)
		context.scaleBy(x: 1.0, y: -1.0)
		
		guard let cgImage = self.cgImage else {return self}
		let rect = CGRect(x: 0, y: 0, width: self.size.width, height: -self.size.height)
		context.clip(to: rect, mask: cgImage)

		// Fill and end the transparency layer
		guard let model = color.cgColor.colorSpace?.model,
			  let colors = color.cgColor.components else {return self}
		
		if(model == .monochrome) {
			context.setFillColor(red: colors[0], green: colors[0], blue: colors[0], alpha: colors[1])
		} else {
			context.setFillColor(red: colors[0], green: colors[1], blue: colors[2], alpha: colors[3])
		}

		contextRect.size.height = -contextRect.size.height;
		contextRect.size.height -= 15;
		context.fill(contextRect);
		context.endTransparencyLayer();

		guard let img = UIGraphicsGetImageFromCurrentImageContext() else {return self}
		UIGraphicsEndImageContext()
		return img
	}

}
