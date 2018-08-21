//
//  DetailsViewController.swift
//  Tumblr
//
//  Created by Rajeev Ram on 8/20/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // UI, UX Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var detailTextLabel: UILabel!
    
    // Backend Logic Variables
    var photoURL: URL?
    var detailText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.af_setImage(withURL: photoURL!)
        //detailTextLabel.text = detailText!
        detailTextLabel.attributedText = removeHTMLFromCaption(captionWithHTML: detailText!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeHTMLFromCaption(captionWithHTML: String) -> NSAttributedString? {
        var captionWithoutHTML: NSAttributedString?
        if let data = captionWithHTML.data(using: .utf8) {
            do {
                captionWithoutHTML = try NSAttributedString(
                    data: data,
                    options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                    documentAttributes: nil)
            }
            catch {
                print("Error parsing HTML caption!")
            }
        }
        return captionWithoutHTML
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
