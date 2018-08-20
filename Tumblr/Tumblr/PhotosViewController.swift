//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Rajeev Ram on 8/20/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // UI, UX Outlets
    @IBOutlet weak var photoTableView: UITableView!
    
    // Backend Logic Properties
    var posts: [[String: Any]] = []

    override func viewDidLoad() {
        photoTableView.delegate = self
        photoTableView.dataSource = self
        photoTableView.rowHeight = 250
        super.viewDidLoad()
        retrieveTumblrAPIData()
        //print(1)
    }
    
    // Make a network request
    func retrieveTumblrAPIData() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                //print(dataDictionary)
                
                // Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // TODO: Reload the table view
                self.photoTableView.reloadData()
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as! PhotoTableViewCell
        cell.photoImageView.af_setImage(withURL: getPhotoURL(rowNumber: indexPath.row)!)
//        let post = posts[indexPath.row]
//        if let photos = post["photos"] as? [[String: Any]] {
//            let photo = photos[0]
//            let originalSize = photo["original_size"] as! [String: Any]
//            let urlString = originalSize["url"] as! String
//            let url = URL(string: urlString)
//            cell.photoImageView.af_setImage(withURL: url!)
//        }
        return cell
    }
    
    func getPhotoString(rowNumber: Int) -> String? {
        var description: String?
        let post = posts[rowNumber]
        if let caption = post["caption"] as! String? {
            description = caption
        }
        return description
    }
    
    func getPhotoURL(rowNumber: Int) -> URL? {
        var url: URL?
        let post = posts[rowNumber]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            url = URL(string: urlString)
        }
        return url
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView = segue.destination as! DetailsViewController
        let cell = sender as! UITableViewCell
        let indexPath = photoTableView.indexPath(for: cell)!
        let url = getPhotoURL(rowNumber: indexPath.row)
        detailView.photoURL = url
        detailView.detailText = getPhotoString(rowNumber: indexPath.row)
        photoTableView.deselectRow(at: indexPath, animated: true)
    }
    
}
