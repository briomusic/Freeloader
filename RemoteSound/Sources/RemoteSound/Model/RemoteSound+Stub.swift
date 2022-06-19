//
//  File.swift
//  
//
//  Created by Brio Taliaferro on 17.06.22.
//

import Foundation

public extension RemoteSound {
	
	enum Stub {
		public static let url = URL(string: "https://google.com")!
		public static let bass = RemoteSound(serviceId: 123, name: "bass", type: "wav", filesize: 999, downloadURL: url, previewURL: url, waveformURL: url)
		public static let drum = RemoteSound(serviceId: 456, name: "drum", type: "wav", filesize: 999, downloadURL: url, previewURL: url, waveformURL: url)

	}
}
