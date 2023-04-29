//
//  FeedViewController.swift
//  PhotoShareApp
//
//  Created by Baran on 27.04.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var postArray = [Post]();
    
    
    @IBOutlet weak var postsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad();
        
        postsTableView.delegate = self;
        postsTableView.dataSource = self;

        getDataFromFirebase();
    }
    
    func getDataFromFirebase(){
        
        let firestoreDb = Firestore.firestore();
        
        firestoreDb.collection("Post").order(by: "insertDate", descending: true).addSnapshotListener { (snapshots, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "Hata");
            } else{
                
                if snapshots?.isEmpty != true && snapshots != nil {
                    
                    self.postArray.removeAll(keepingCapacity: false);
                    
                    for data in snapshots!.documents {
                        
                        if let imageUrl = data.get("imageUrl") as? String {
                            if let comment = data.get("comment") as? String {
                                if let email = data.get("email") as? String {
                                    self.postArray.append(Post(email: email, imageUrl: imageUrl, comment: comment));
                                }
                            }
                        }
                    }
                    self.postsTableView.reloadData();
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell;
        cell.commentText.text = self.postArray[indexPath.row].comment;
        cell.emailText.text = self.postArray[indexPath.row].email;
        cell.postImage.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageUrl));
        return cell;
    }

}
