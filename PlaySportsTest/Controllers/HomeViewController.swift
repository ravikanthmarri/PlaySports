//
//  ViewController.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "SportsVideoCellId"
    fileprivate let headerId = "PlaySportsHeaderId"
    fileprivate let padding:CGFloat = 16.0
    let apiClient = ApiClient()
    var rawItems = [RawItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupNavigationItems()
        setupCollectionView()
        fetchVideos()
    }
    
    func fetchVideos(){
        apiClient.getVideos { [weak self] rawItems, error in
            guard let strongSelf = self else { return }
            if let error = error{
                print(error)
                return
            }
            if let items = rawItems{
                strongSelf.rawItems = items
                DispatchQueue.main.async {
                    strongSelf.collectionView?.reloadData()
                }
            }
        }
    }
    
    func setupNavigationItems() {
        navigationItem.title = "Play Sports Network"
    }
    
    fileprivate func setupCollectionView() {
        collectionView?.backgroundColor = .gray
        collectionView?.register(PlaySportsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(SportsVideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK:- UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PlaySportsHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rawItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SportsVideoCell
        cell.videoItem = self.rawItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width - 2 * padding
        return CGSize(width: width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let detailsViewController = DetailViewController()
//        //detailsViewController.remedy = remedy
//        let navController = UINavigationController(rootViewController: detailsViewController)
//        self.present(navController, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailNavController") as! UINavigationController
        let detailController = controller.topViewController as! DetailViewController
        detailController.videoId = self.rawItems[indexPath.item].id.videoId
        self.present(controller, animated: true, completion: nil)
    }
    
}

