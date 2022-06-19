//
//  ViewController.swift
//  RemoteSoundTester
//
//  Created by Brio Taliaferro on 17.06.22.
//

import UIKit
import RemoteSound

class ViewController: UIViewController {
	let remoteSoundVC = RemoteSoundViewController(nibName: nil, bundle: nil)

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.addChild(remoteSoundVC)
		self.view.addSubview(remoteSoundVC.view)
		remoteSoundVC.view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: remoteSoundVC.view.topAnchor),
			view.rightAnchor.constraint(equalTo: remoteSoundVC.view.rightAnchor),
			view.bottomAnchor.constraint(equalTo: remoteSoundVC.view.bottomAnchor),
			view.leftAnchor.constraint(equalTo: remoteSoundVC.view.leftAnchor)
		])

		
		let list = RemoteSoundList(sounds: [RemoteSound.Stub.bass, RemoteSound.Stub.drum])
		remoteSoundVC.list = list
		
	}
}

