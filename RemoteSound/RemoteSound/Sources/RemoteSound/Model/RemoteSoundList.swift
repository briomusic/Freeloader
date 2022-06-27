//
//  File.swift
//  
//
//  Created by Brio Taliaferro on 15.06.22.
//

import Foundation

public struct RemoteSoundList {
	var sounds: [RemoteSound]
	
	public init(sounds: [RemoteSound]) {
		self.sounds = sounds
	}
}
