//
//  CameraController.swift
//  BusinessCards
//
//  Created by Ajani on 29/12/2016.
//  Copyright © 2016 Ajani. All rights reserved.
//

import UIKit

class CameraController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,URLSessionDelegate {
    
    private var imagePicker: UIImagePickerController!

    @IBOutlet weak var imageToRead: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        present(imagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageToRead.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.postAndGetResult()
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y:0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    

    private func generateBoundaryString() -> String {
        return "Boundary--\(NSUUID().uuidString)"
    }
    
    //OCR settings
    let apiKey = "7785fb90-db1f-454b-9b19-37f389dd50ec"
    let endpoint: URL = URL(string: "https://api.idolondemand.com/1/api/sync/ocrdocument/v1")!
    //Reading modes
    let mode1 = "document_photo"   //This is best for photos
    let mode2 = "document_scan"  //Best for scanned documents
    let mode3 = "scene_photo"  //Best for scenes
    
    
    func postAndGetResult() {
     var request :URLRequest = URLRequest(url: endpoint)
     request.httpMethod = "POST"
     let boundary = self.generateBoundaryString()
     request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
     let config = URLSessionConfiguration.default
     let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        
     let myImage = resizeImage(image: imageToRead.image!, targetSize: CGSize(width: 1280, height: 720))
     let imageData = UIImageJPEGRepresentation(myImage, 0.2)
        if imageData != nil{
            
           var body = Data()
           body.append("--\(boundary)\r\n".data(using: .utf8)!)
           body.append("Content-Disposition: form-data; name=\"apikey\"\r\n\r\n".data(using: .utf8)!)
           body.append("\(apiKey)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\("file")\"; filename=\"\("image.jpeg")\"\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Type: JPEG\r\n\r\n".data(using: .utf8)!)
            body.append(imageData! as Data)
            body.append("\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"languages\"\r\n\r\n".data(using: .utf8)!)
            body.append("\("lt")\r\n".data(using: .utf8)!)
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            request.httpBody = body
            request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
          
        
        
        let task = session.dataTask(with: request) {data,response,error in
            if data != nil {
            let responseString = String(data: data!, encoding: .utf8)
               self.parseResult(data: responseString!)
            }
        }
        
        task.resume()
        }
    }


    func parseResult(data: String) {
        let responseData = data.data(using: .utf8)!
        do {
          let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! NSDictionary
          let json = JSON(jsonObject)
          print(json)
          if let ocr_results = json["text_block"][0]["text"].string {
             print(ocr_results)
            
           let editViewController1 =  self.storyboard?.instantiateViewController(withIdentifier: "EditViewController1") as! EditViewController1
            self.present(editViewController1, animated: false, completion:nil)
            editViewController1.initializeFields(textArray: ocr_results.components(separatedBy: "\n"))
          }
        } catch {
            
        }

    }
}
