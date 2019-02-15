//
//  DetailViewController.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    
    var videoId: String?
    let apiClient = ApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarButtons()
        setupNavigationItems()
        loadVideoDetails()
//        let youtubeVideoDurationString = "PT3H2M31S"
//        let result_Hour_Minute_Second = youtubeVideoDurationString.parseVideoDurationOfYoutubeAPI()
//        print("result_Hour_Minute_Second: \(result_Hour_Minute_Second)")
    }
    
    func setupNavigationItems() {
        navigationItem.title = "Details"
    }

    func loadVideoDetails() {
        guard let videoId = videoId else {
            return
        }
        apiClient.getVideoDetails(for: videoId) { [weak self] itemDetail, error in
            guard let strongSelf = self else { return }
            if let err = error {
                print(err)
            }
            if let videoDetail = itemDetail?.first {
                DispatchQueue.main.async {
                    strongSelf.updateUI(with: videoDetail)
                }
            }
        }
        apiClient.getComments(for: videoId) { [weak self] comments, error in
            if let err = error {
                print(err)
            }
        }
    }
    
    func updateUI(with videoDetail: ItemDetail){
        self.titleLabel.text = videoDetail.snippet.title
        self.descriptionLabel.text = videoDetail.snippet.description
        let thumbnailUrl = URL(string: videoDetail.snippet.thumbnails.medium.url)
        self.thumbnailImageView.sd_setImage(with: thumbnailUrl, completed: nil)
        self.durationLabel.text = videoDetail.contentDetails.duration.parseVideoDurationOfYoutubeAPI()
        self.publishedLabel.text = formatDate(from: videoDetail.snippet.publishedAt)
    }
    
    func formatDate(from publishedDate:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        formatter.formatterBehavior = .default
        let date = formatter.date(from: publishedDate)
        formatter.dateFormat = "dd-MMM-yyyy"
        if let unwrappedDate = date {
            return formatter.string(from: unwrappedDate)
        }else {
            return ""
        }
    }
    
    func setupNavBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(close))
    }
    
    @objc func close() {
        self.dismiss(animated: true)
    }

}
