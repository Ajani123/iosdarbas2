//
//  CameraController.swift
//  BusinessCards
//
//  Created by Ajani on 29/12/2016.
//  Copyright © 2016 Ajani. All rights reserved.
//

import UIKit

class CameraController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,URLSessionDelegate {
    
  //  var imageToRead: UIImageView!
   // @IBOutlet weak var textFromOcr: UITextView!
    
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
        // Do any additional setup after loading the view, typically from a nib.
        //default startup values
      //  textFromOcr.isHidden = true
      //  ocrImageUrl = ocrImageUrl1
        // downloadImage(fromURL: ocrImageUrl)
      //  addDropShadow()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageToRead.image = info[UIImagePickerControllerOriginalImage] as? UIImage
      
            if let data = UIImagePNGRepresentation(imageToRead.image!) {
                let filename = getDocumentsDirectory().appendingPathComponent("img.png")
                try? data.write(to: filename)
            }
        
        self.postAndGetResult()
    //    self.textFromOcr.isHidden = true
    //    self.imageToRead.isHidden = false
       // self.imageToRead.image = imageToRead.image
    }
    func getArrayOfBytesFromImage(imageData:NSData) -> NSMutableArray
    {
        
        // the number of elements:
        let count = imageData.length / MemoryLayout<UInt8>.size
        
        // create array of appropriate length:
        var bytes = [UInt8](repeating: 0, count: count)
        
        // copy bytes into array
        imageData.getBytes(&bytes, length:count * MemoryLayout<UInt8>.size)
        
        var byteArray:NSMutableArray = NSMutableArray()
        
        for  i in 0 ... count-1 {
            byteArray.add(NSNumber(value: bytes[i]))
        }
        
        return byteArray
        
        
    }
    
    //OCR settings
    let apiKey = "7785fb90-db1f-454b-9b19-37f389dd50ec"
    //Sample Images - Use yours if you want.
    let ocrImageUrl1 = "http://www.joyintheaftermath.com/wp-content/uploads/2014/08/meaningoflife.png"
    let ocrImageUrl2 = "http://i.imgur.com/8UcN9ly.jpg"
    let ocrImageUrl3 = "http://www.chupamobile.com/blog/wp-content/uploads/2014/10/sebastian_6.jpg"
    let ocrImageUrl4 = "http://i.imgur.com/iG4ZCw7.jpg"
    var ocrImageUrl = ""
    //API call address of IDOL ON DEMAND
   // let endpoint: URL = URL(string: "https://api.idolondemand.com/1/api/sync/ocrdocument/v1?apikey=7785fb90-db1f-454b-9b19-37f389dd50ec&file=")!
    let endpoint: URL = URL(string: "https://api.idolondemand.com/1/api/sync/ocrdocument/v1")!
    //Reading modes
    let mode1 = "&mode=document_photo"   //This is best for photos
    let mode2 = "&mode=document_scan"  //Best for scanned documents
    let mode3 = "&mode=scene_photo"  //Best for scenes
    
    var imageID = 1
    
    
    //IDOL on Demand Call
    func postAndGetResult(){
        var request :URLRequest = URLRequest(url: endpoint)
       //let request = endpoint as URL;
        request.httpMethod = "POST"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        //change mode here according to type of the image
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = getDocumentsDirectory().appendingPathComponent("img.png")
            let image    = UIImage(contentsOfFile: imageURL.path)
            // Do whatever you want with the image
               var myImage = resizeImage(image: image!, targetSize: CGSize(width: 1280, height: 720))
        let image2 = UIImageJPEGRepresentation(myImage, 0.1) as Data!
            //print(image2)
          //  let datastring = String(data: image2!, encoding: .utf8)
        //let b4 = String(Int(datastring! as String, radix: 16)!, radix: 2)
            let someshit = String(data: (image2?.base64EncodedData())!, encoding: .utf8)
            let decodedData = NSData(base64Encoded: someshit!, options: NSData.Base64DecodingOptions(rawValue: 0))
                //let decodedString = NSString(data: someshit as! Data, encoding: String.Encoding.utf8.rawValue)
       //         print(decodedString) // foo
         
            //let data = NSData(base64Encoded: decodedString as! String, options: NSData.Base64DecodingOptions(rawValue: 0))
            
            // Convert back to a string
            let base64Decoded = NSString(data: decodedData as! Data, encoding: String.Encoding.utf8.rawValue)
            print("Decoded:  \(base64Decoded)")
            let str = String(bytes: image2!, encoding: String.Encoding.utf8)
            print(str)
            // my plain data
            if let image2=image2{
                var stri=""
                /*for i in 0...image2.count-1{
                    stri.append(image2[i])
                }*/
                let imgarray = [UInt8](image2)
                let imgarray2 : [String] = toBinaryStringArray(imgarray)
                for i in 0 ... imgarray2.count-1{
                    stri.append(imgarray2[i])
                    stri.append(" ")
                }
                //print(image2[0])
                let payload = "apikey=\(apiKey)&file=\(image2)\(mode3)".data(using: String.Encoding.utf8)
            
       // print(payload?.base64EncodedString())
/*
     //   let imageData = UIImagePNGRepresentation(imageToRead.image!)
     var myImage = resizeImage(image: imageToRead.image!, targetSize: CGSize(width: 1280, height: 720))
     let imageData =   UIImageJPEGRepresentation(myImage, 0.2)
        if imageData != nil{
            print(myImage.size)
     //       imageToRead.image=resizeImage
            let body = NSMutableData()
            let request = NSMutableURLRequest(url: NSURL(string:endpoint.absoluteString)! as URL)
     //       _ = URLSession.shared
       
            request.httpMethod = "POST"
            
            let boundary = NSUUID().uuidString// NSString(format: "---------------------------14737809831466499882746641449")
         
        //    let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
            
            //  println("Content Type \(contentType)")
        //    request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
     
            
            // Title
         //   body.append(NSString(format: "\r\n--%@\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
            //body.append(NSString(format:"Content-Disposition: form-data; name=\"title\"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
//            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)

  //          body.append("Content-Disposition: form-data; name=\"apikey\"\r\n\r\n".data(using: String.Encoding.utf8)!)
     //       body.append("\(apiKey)\r\n".data(using: String.Encoding.utf8)!)
            
            // Image
           /* body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format:"Content-Disposition: form-data; name=\"profile_img\"; filename=\"img.jpg\"\\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(imageData!)
            body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)*/
           // body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            //body.append("Content-Disposition: form-data; name=\"\("file")\"; filename=\"\("sumfilename.jpeg")\"\r\n".data(using: String.Encoding.utf8)!)

            body.append("Content-Type: JPEG\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append(imageData!)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
          /*  var urlString : String = "https://api.idolondemand.com/1/api/sync/ocrdocument/v1?apikey=7785fb90-db1f-454b-9b19-37f389dd50ec&file="
           // urlString.append((imageData?.base64EncodedString())!)
            let imageString = String(describing: imageData!)
            urlString += imageString*/
            
                let endpoint: URL = URL(string: urlString)!
            var request :URLRequest = URLRequest(url: endpoint)
request.httpMethod = "POST"
         //   request.httpBody = body as Data
            request.setValue("\(body.length)", forHTTPHeaderField: "Content-Length")
          
        */
        
        let task = session.uploadTask(with: request, from: payload! as Data) {data,response,error in
 
          //  let task = session.dataTask(with: request)  {data,response,error in
           if data != nil {
            let responseString = String(data: data!, encoding: .utf8)
               self.doShit(data: responseString!)
            }
        }
        
        task.resume()
            }}
    }

    
    func doShit(data: String) {
        let responseData = data.data(using: .utf8)!
        do {
        let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! NSDictionary
            
 
             let json = JSON(jsonObject)
            print(json)
             if let ocr_results = json["text_block"][0]["text"].string {
             print(ocr_results)
             
           //  DispatchQueue.main.asynchronously(execute: {
        //     self.textFromOcr.text = ocr_results
        //     self.textFromOcr.isHidden = false
            // self.imageToRead.isHidden = true
           //  })
             }
        } catch {
            
        }

    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    //Download images from the image location to display
    /*func downloadImage(fromURL:String){
        let url:NSURL = NSURL(string:fromURL)!
        let request:NSURLRequest = NSURLRequest(url:url as URL)
        let queue:OperationQueue = OperationQueue()
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue, completionHandler:{ (response: URLResponse!, data: NSData!, error: NSError!) -> Void in
            dispatch_async(dispatch_get_main_queue(),{
                self.textFromOcr.hidden = true
                self.imageToRead.hidden = false
                self.imageToRead.image = UIImage(data: data)
            })
        })
    }
    */
    
    //Skip to next image
    @IBAction func nextImage(sender: AnyObject) {
    //    self.textFromOcr.hidden = true
      //  self.imageToRead.hidden = false
        imageID += 1
        if imageID == 1{
            ocrImageUrl = ocrImageUrl1
        }else if imageID == 2 {
            ocrImageUrl = ocrImageUrl2
            
        }else if imageID == 3 {
            ocrImageUrl = ocrImageUrl3
            
        }else if imageID == 4 {
            ocrImageUrl = ocrImageUrl4
            imageID = 0
        }
      //  downloadImage(fromURL: ocrImageUrl)
        
    }
    
    
    
    
    
    func addDropShadow(){
        imageToRead.layer.shadowColor = UIColor.black.cgColor
     //   imageToRead.layer.shadowOffset = CGSizeMake(0, 1);
        imageToRead.layer.shadowOpacity = 1
        imageToRead.layer.shadowRadius = 4.0
        imageToRead.clipsToBounds = false
        
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
    
    func toBinaryStringArray( _ array:[UInt8] ) -> [String] {
        
        var result:[String] = []
        
        for elem in array {
            
            let binStr = byteToBinaryString( elem )
            result.append( binStr )
        }
        
        return result
    }
    
    func byteToBinaryString( _ byte:UInt8 ) -> String {
        
        var result = String( byte, radix: 2)
        
        while result.characters.count < 8 {
            
            result = "0" + result
        }
        
        return result
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
