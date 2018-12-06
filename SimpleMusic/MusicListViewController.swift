//
//  MusicListViewController.swift
//  SimpleMusic
//
//  Created by Kirill Shteffen on 05/12/2018.
//  Copyright © 2018 BlackBricks. All rights reserved.
//

import UIKit
import MediaPlayer
import HMSegmentedControl

enum Categories: Int {
    case all = 0
    case basic = 1
    case custom = 2
    case shared = 3
    
    func title() -> String {
        switch self {
        case .all:
            return "Songs"
        case .basic:
            return "Artists"
        case .custom:
            return "Albums"
        case .shared:
            return "Playlists"
        }
    }
    
    static func sections() -> [String] {
        return [Categories.all.title(), Categories.basic.title(), Categories.custom.title(), Categories.shared.title()]
    }
}

class MusicListViewController: UIViewController, MPMediaPickerControllerDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segmentedContainer: UIView!
    var segmentControl: HMSegmentedControl?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createSegmentView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    segmentControl?.frame = segmentedContainer.bounds
        //pickMedia()
    }
    
    private func createSegmentView() {
        self.view.layoutIfNeeded()
        guard let segmentView = HMSegmentedControl(sectionTitles: Categories.sections()) else {
            return
        }
        
        segmentView.frame = segmentedContainer.bounds
        segmentView.segmentWidthStyle = .fixed
        segmentView.backgroundColor = UIColor.lightGray
        segmentView.selectionIndicatorColor = UIColor.black
        segmentView.selectionIndicatorLocation = .down
        segmentView.selectionIndicatorHeight = 2
        segmentView.selectionStyle = .fullWidthStripe
        
        segmentedContainer.addSubview(segmentView)
        
        segmentControl = segmentView
    }
    
    fileprivate func showAlert(title: String?, message: String?) {
        guard
            let title = title,
            let message = message else {
                return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        // Checking for setting is opened or not
                        print("Setting is opened: \(success)")
                    })
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func pickMedia() {
        let mediaPicker = MPMediaPickerController(mediaTypes: .music)
        mediaPicker.showsCloudItems = false
        mediaPicker.delegate = self
        if #available(iOS 9.3, *) {
            MPMediaLibrary.requestAuthorization() { [unowned self] status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        print ("MEDIA IS AVAILABLE")
                        self.present(mediaPicker, animated: true, completion: {})
                    } else {
                        print ("Media blocked")
                        self.showAlert(title: "Media access is blocked", message: "Do you want to enable it in the settings menu?")
                        return
                    }
                }
            }
        } else {
            present(mediaPicker, animated: true, completion: {})
        }
    }
    
}
extension MusicListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicListCollectionViewCell", for: indexPath) as? MusicListCollectionViewCell else {
            return UICollectionViewCell ()
        }
        return cell
    }
}
