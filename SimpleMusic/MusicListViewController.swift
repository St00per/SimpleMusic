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

class MusicListViewController: UIViewController {

    
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
        segmentView.selectionIndicatorHeight = 4
        segmentView.selectionStyle = .fullWidthStripe
        
        segmentedContainer.addSubview(segmentView)
        
        segmentControl = segmentView
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
