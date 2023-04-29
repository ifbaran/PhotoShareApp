//
//  UploadViewController.swift
//  PhotoShareApp
//
//  Created by Baran on 27.04.2023.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTheKeyboard));
        view.addGestureRecognizer(gestureRecognizer);
        
        postImage.isUserInteractionEnabled = true;
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage));
        postImage.addGestureRecognizer(imageGestureRecognizer);
    }
    

    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage = Storage.storage();
        let storageReference = storage.reference();
        
        let mediaFolder = storageReference.child("media");
        
        if let data = postImage.image?.jpegData(compressionQuality: 0.5){
            
            let uuidString = UUID().uuidString;
            let imageReference = mediaFolder.child("\(uuidString).jpg");
            
            imageReference.putData(data, metadata: nil) { (storageMetaData, storageError) in
                if storageError != nil {
                    self.errorMessage(messageTitle: "Hata!", messageBody: storageError?.localizedDescription ?? "Hata alındı tekrar deneyiniz!");
                } else {
                    imageReference.downloadURL { (url, downloadError) in
                        if downloadError == nil {
                            
                            if let imageUrl = url?.absoluteString {
                                
                                let firesStoreDatabase = Firestore.firestore();
                                let data = [
                                    "imageUrl" : imageUrl,
                                    "email" : Auth.auth().currentUser!.email!,
                                    "insertDate" : Timestamp(date: Date.now),
                                    "comment" : self.commentTextField.text ?? "Yorum boş bırakılmış"
                                ] as [String: Any];
                                firesStoreDatabase.collection("Post").addDocument(data: data) { uploadError in
                                    if uploadError != nil {
                                        self.errorMessage(messageTitle: "Hata!", messageBody: storageError?.localizedDescription ?? "Post yüklenirken hata alındı tekrar deneyiniz!");
                                        print(data);
                                    } else {
                                        self.commentTextField.text = "";
                                        self.postImage.image = UIImage(systemName: "square.and.arrow.up.fill");
                                        self.tabBarController?.selectedIndex = 0;
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
    @objc func closeTheKeyboard(){
        view.endEditing(true);
    }
    
    @objc func selectImage(){
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary;
        present(imagePicker, animated: true);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.originalImage] as? UIImage;
        self.dismiss(animated: true);
    }
    
    func errorMessage(messageTitle: String, messageBody: String){
        let alert = UIAlertController(title: messageTitle, message: messageBody, preferredStyle: .alert);
        let okButton = UIAlertAction(title: "OK", style: .default);
        alert.addAction(okButton);
        self.present(alert, animated: true);
    }
}
