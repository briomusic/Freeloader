//
//  RemoteSoundViewController.swift
//  
//
//  Created by Brio Taliaferro on 19.06.22.
//

import UIKit
import AVKit
import JGProgressHUD

public typealias RemoteSoundCallback = (String, Int) -> Void

public class RemoteSoundViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
	
	static let cellIdentifier = "RemoteSoundCell"

	@IBOutlet var tableView: UITableView!
	@IBOutlet var searchTermTextField: UITextField!
	@IBOutlet var previewStopButton: UIButton!
	
	let hud: JGProgressHUD = {
		let hud = JGProgressHUD()
		hud.textLabel.text = "Loading..."
		return hud
	}()
	
	private lazy var datasource = makeDataSource()
	var avPlayer : AVPlayer?


	public var list = RemoteSoundList(sounds: []) {
		didSet {
			hud.dismiss()
			update()
		}
	}
	
	public var callback: RemoteSoundCallback?
		
	var searchTerm = "" {
		didSet {
			hud.show(in: self.view)
			callback?(searchTerm, 0)
		}
	}
	
	// MARK: lifecycle
	
	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: Bundle.module)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = datasource
		tableView.delegate = self
		
		tableView.register(RemoteSoundCell.self, forCellReuseIdentifier: RemoteSoundViewController.cellIdentifier)

		searchTermTextField.delegate = self
		previewStopButton.isHidden = true
	}
	
	
	// MARK: ui actions
		
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	public func textFieldDidEndEditing(_ textField: UITextField) {
		searchTerm = searchTermTextField.text ?? ""
	}
	
	// MARK: preview
	
	func preview(sound: RemoteSound) {
		avPlayer = AVPlayer(url: sound.previewURL)
		avPlayer?.play()

		NotificationCenter.default.addObserver(self, selector: #selector(avPlayerReachedEnd), name:NSNotification.Name.AVPlayerItemDidPlayToEndTime , object: nil)
		previewStopButton.isHidden = false
	}
	
	@IBAction func stopPreviewTapped(_ sender: UIButton) {
		avPlayer?.pause()
		previewStopButton.isHidden = true
	}
	
	@objc func avPlayerReachedEnd() {
		previewStopButton.isHidden = true
	}
}

extension RemoteSoundViewController {
	
	func makeDataSource() -> UITableViewDiffableDataSource<Int, RemoteSound> {
		
		return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, item in
			let sound = self.list.sounds[indexPath.row]
			
			let cell = tableView.dequeueReusableCell(withIdentifier: RemoteSoundViewController.cellIdentifier, for: indexPath) as! RemoteSoundCell
			
			cell.configure(sound: sound)
			cell.previewCallback = { sound in
				self.preview(sound: sound)
			}
			
			return cell
		}
	}
	
	func update() {
		var snapshot = datasource.snapshot()
		snapshot.deleteAllItems()
		snapshot.appendSections([0])
		snapshot.appendItems(list.sounds, toSection: 0)
		datasource.apply(snapshot, animatingDifferences: true)
	}
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
}

