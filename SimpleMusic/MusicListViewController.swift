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
    
    
    @IBOutlet weak var playerView: UIView!
    var audioPlayer: AVAudioPlayer!
    
    var previousContentOffset: CGFloat = 0
    var currentContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createSegmentView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    segmentControl?.frame = segmentedContainer.bounds
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
        segmentView.addTarget(self, action: #selector(segmentChanged(segment:)), for: UIControl.Event.valueChanged)
        
        segmentedContainer.addSubview(segmentView)
        
        segmentControl = segmentView
    }
    
    
    
    @objc func segmentChanged(segment: HMSegmentedControl) {
        let visibleItems = collectionView.indexPathsForVisibleItems
        let lastVisibleItem = collectionView.indexPathsForVisibleItems[collectionView.indexPathsForVisibleItems.count - 1]
        if segment.selectedSegmentIndex == 0 {
            collectionView.scrollToItem(at: [0,0], at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        if segment.selectedSegmentIndex == 1 {
            collectionView.scrollToItem(at: [0,7], at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        if segment.selectedSegmentIndex == 2 {
            collectionView.scrollToItem(at: [0,13], at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        if segment.selectedSegmentIndex == 3 {
            collectionView.scrollToItem(at: [0,19], at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
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
        cell.viewController = self
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        previousContentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (segmentControl?.selectedSegmentIndex ?? 0) <= 4 {
            currentContentOffset = scrollView.contentOffset.x
        }
        
        if currentContentOffset-previousContentOffset == 414, (segmentControl?.selectedSegmentIndex ?? 0) < 4 {
            segmentControl?.selectedSegmentIndex += 1
        }
        if currentContentOffset-previousContentOffset == -414, (segmentControl?.selectedSegmentIndex ?? 0) > 0 {
            segmentControl?.selectedSegmentIndex -= 1
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print (scrollView.contentOffset)
//    }
}
