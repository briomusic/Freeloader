//
//  ViewController.swift
//  FreesoundTester
//
//  Created by Brio Taliaferro on 16.06.22.
//

import UIKit
import Freesound
import RemoteSound

class ViewController: UIViewController {
	var service = FreesoundService()
	
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
		
		remoteSoundVC.callback = { [weak self] searchTerm, maxLength in
			self?.loadSounds(query: searchTerm, maxLength: maxLength)
		}
	}
	
	func loadSounds(query: String, maxLength: Int) {
		self.service.fetch(searchType: .term, query: query, maxDuration: Double(maxLength)) { list, error in
			DispatchQueue.main.async {
				if let error = error {
					self.remoteSoundVC.list = RemoteSoundList(sounds: [])
					let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
					let action = UIAlertAction(title: "Ok", style: .default)
					alert.addAction(action)
					self.present(alert, animated: true)
				} else if let list = list {
					self.remoteSoundVC.list = list
				}
			}
		}
	}


}

