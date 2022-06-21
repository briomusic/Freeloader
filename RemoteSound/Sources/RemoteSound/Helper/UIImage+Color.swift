//
//  File.swift
//  
//
//  Created by Brio Taliaferro on 21.06.22.
//

import Foundation
import UIKit

public extension UIImage {	
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
