//
//  APIWrapper.swift
//
//  Created by Zafran zaman


import Foundation
import AVKit


struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String, imageName name : String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = name
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

////////////////////////
/// This is the Response Returned by Web API Action (i.e. Function)
class APIMessage{
    var ResponseCode : Int = 404// Not-Ok
    var ResponseData : Data?
    var ResponseMessage : String = "OK"
}


//////////////////////
/// This class Is a wrapper which will handle Web API get and post method calls.
class APIWrapper{
    static let imgBaseURLString = "http://192.168.250.48/FypFinalApi/"
    private let baseURLString = "http://192.168.250.48/FypFinalApi/api/"
    //////httppatch
    func patchMethodCall(controllerName:String,actionName:String,pid:Int,cid:Int)->APIMessage {
        let apiMessage = APIMessage()
        
        let completePath: String =  "\(baseURLString)\(controllerName)/\(actionName)?pid=\(pid)&cid=\(cid)"
        guard let url = URL(string: completePath) else{
            apiMessage.ResponseCode = 209//error
            apiMessage.ResponseMessage = "Error : cannot create URL"
            return apiMessage
        }
        let group = DispatchGroup()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                apiMessage.ResponseMessage = error.debugDescription
                print("error calling \(controllerName)\(actionName)")
                group.leave()
                print(error!)
                return
                
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            
            guard let responseData = data  else{
                apiMessage.ResponseMessage = "error: did not recive data"
                group.leave()
                return
            }
            
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
  ////  stoooooooock
    
    func patchStockMethodCall(controllerName:String,actionName:String,pid:Int,qty:Int)->APIMessage {
        let apiMessage = APIMessage()
        
        let completePath: String =  "\(baseURLString)\(controllerName)/\(actionName)?pid=\(pid)&qty=\(qty)"
        guard let url = URL(string: completePath) else{
            apiMessage.ResponseCode = 209//error
            apiMessage.ResponseMessage = "Error : cannot create URL"
            return apiMessage
        }
        let group = DispatchGroup()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                apiMessage.ResponseMessage = error.debugDescription
                print("error calling \(controllerName)\(actionName)")
                group.leave()
                print(error!)
                return
                
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            
            guard let responseData = data  else{
                apiMessage.ResponseMessage = "error: did not recive data"
                group.leave()
                return
            }
            
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    
    
    
    ///////DElete
    func DeleteMethod(controllerName:String,actionName:String,id:Int)->APIMessage {
        let apiMessage = APIMessage()
        
        let completePath: String =  "\(baseURLString)\(controllerName)/\(actionName)?id=\(id)"
        guard let url = URL(string: completePath) else{
            apiMessage.ResponseCode = 209//error
            apiMessage.ResponseMessage = "Error : cannot create URL"
            return apiMessage
        }
        let group = DispatchGroup()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                apiMessage.ResponseMessage = error.debugDescription
                print("error calling \(controllerName)\(actionName)")
                group.leave()
                print(error!)
                return
                
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            
            guard let responseData = data  else{
                apiMessage.ResponseMessage = "error: did not recive data"
                group.leave()
                return
            }
            
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    
    
    
    ///////
    ///////////
    ///// This is getLocation method
//////////////
    func getLocationMethod(controllerName:String,actionName:String,id:Int)->APIMessage {
        let apiMessage = APIMessage()
        
        let completePath: String =  "\(baseURLString)\(controllerName)/\(actionName)?id=\(id)"
        guard let url = URL(string: completePath) else{
            apiMessage.ResponseCode = 209//error
            apiMessage.ResponseMessage = "Error : cannot create URL"
            return apiMessage
        }
        let group = DispatchGroup()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                apiMessage.ResponseMessage = error.debugDescription
                print("error calling \(controllerName)\(actionName)")
                group.leave()
                print(error!)
                return
                
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            
            guard let responseData = data  else{
                apiMessage.ResponseMessage = "error: did not recive data"
                group.leave()
                return
            }
            
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    ////////HTTPPATCH
    ////////
    func Patch(controllerName:String,actionName:String,id:Int)->APIMessage {
        let apiMessage = APIMessage()
        
        let completePath: String =  "\(baseURLString)\(controllerName)/\(actionName)?oid=\(id)"
        guard let url = URL(string: completePath) else{
            apiMessage.ResponseCode = 209//error
            apiMessage.ResponseMessage = "Error : cannot create URL"
            return apiMessage
        }
        let group = DispatchGroup()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                apiMessage.ResponseMessage = error.debugDescription
                print("error calling \(controllerName)\(actionName)")
                group.leave()
                print(error!)
                return
                
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            
            guard let responseData = data  else{
                apiMessage.ResponseMessage = "error: did not recive data"
                group.leave()
                return
            }
            
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    
    
    
    ///////////////////////////
    //// This is for HTTPGet methods
    ////////////////////////////
    func getMethodCall(controllerName:String,actionName:String)->APIMessage {
        let apiMessage = APIMessage()
        
        let completePath: String =  "\(baseURLString)\(controllerName)/\(actionName)"
        guard let url = URL(string: completePath) else{
            apiMessage.ResponseCode = 209//error
            apiMessage.ResponseMessage = "Error : cannot create URL"
            return apiMessage
        }
        let group = DispatchGroup()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                apiMessage.ResponseMessage = error.debugDescription
                print("error calling \(controllerName)\(actionName)")
                group.leave()
                print(error!)
                return
                
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            
            guard let responseData = data  else{
                apiMessage.ResponseMessage = "error: did not recive data"
                group.leave()
                return
            }
            
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    
    /////////////////////////
    /// This is for HTTPPost methods
    ////////////////////////////
    func postMethodCall(controllerName:String,actionName:String,httpBody:Data)->APIMessage {
        let apiMessage = APIMessage()
        
        let completePath: String =  "\(baseURLString)\(controllerName)/\(actionName)"
        guard let url = URL(string: completePath) else{
            apiMessage.ResponseCode = 209//error
            apiMessage.ResponseMessage = "Error : cannot create URL"
            return apiMessage
        }
        let group = DispatchGroup()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = httpBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                apiMessage.ResponseMessage = error.debugDescription
                print("error calling \(controllerName)\(actionName)")
                group.leave()
                print(error!)
                return
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            
            guard let responseData = data  else{
                apiMessage.ResponseMessage = "error: did not recive data"
                group.leave()
                return
                
            }
            apiMessage.ResponseData = responseData
            
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    
    
    
    ////post list of stock
    
    
    

    func UploadImageToServerReal(cJson:Data, endPoint:String,params:[String:String])->APIMessage {
        let apiMessage = APIMessage()

        let todoEndpoint: String =  "\(baseURLString)\(endPoint)"
        guard let url = URL(string: todoEndpoint) else{
            apiMessage.ResponseCode = 209//error
            print("Error : cannot create URL")
            return apiMessage
        }
        let group = DispatchGroup()

        //let params = ["user" : "abc"]
        let boundary = "Boundary-\(UUID().uuidString)"

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = createBody(parameters: params,
                                         boundary: boundary,
                                         data: cJson,//UIImageJPEGRepresentation(chosenImage, 0.7)!,
                                         mimeType: "image/jpg",
                                         filename: "hello.jpg")

        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("multipart/form-data",forHTTPHeaderField: "Accept")


        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){

            (data, response, error) in

            guard error == nil else {

                print("error calling \(endPoint)")
                group.leave()
                print(error!)
                return

            }

            guard let responseData = data  else{

                print("error: did not recive data")
                group.leave()
                return

            }

            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            apiMessage.ResponseData = responseData

            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description

            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    
    func uploadImageToServer(images imgs:[Media], parameters params : [String:String]?,endPoint : String) -> APIMessage{
        let apiMessage = APIMessage()
        let todoEndpoint: String =  "\(baseURLString)\(endPoint)"
        guard let url = URL(string: todoEndpoint) else{
            apiMessage.ResponseCode = 209//error
            print("Error : cannot create URL")
            return apiMessage
        }
        
        let group = DispatchGroup()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        //create boundary
        let boundary = generateBoundary()
        //set content type
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //call createDataBody method
        let dataBody = createDataBody(withParameters: params, media: imgs, boundary: boundary)
        urlRequest.httpBody = dataBody
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            guard error == nil else {
                print("error calling \(endPoint)")
                group.leave()
                print(error!)
                return
                
            }
            guard let responseData = data  else{
                print("error: did not recive data")
                group.leave()
                return
                
            }
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    func uploadImageToServer(images imgs:[Media], parameters params : Data?,endPoint : String) -> APIMessage{
        let apiMessage = APIMessage()
        let todoEndpoint: String =  "\(baseURLString)\(endPoint)"
        guard let url = URL(string: todoEndpoint) else{
            apiMessage.ResponseCode = 209//error
            print("Error : cannot create URL")
            return apiMessage
        }
        let group = DispatchGroup()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        //create boundary
        let boundary = generateBoundary()
        //set content type
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //call createDataBody method
        let dataBody = createDataBody(withParameters: params, media: imgs, boundary: boundary)
        urlRequest.httpBody = dataBody
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            guard error == nil else {
                print("error calling \(endPoint)")
                group.leave()
                print(error!)
                return
                
            }
            guard let responseData = data  else{
                print("error: did not recive data")
                group.leave()
                return
                
            }
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            apiMessage.ResponseData = responseData
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
    
    func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
    }
    
   private func createDataBody(withParameters params: [String:String]?, media: [Media]?, boundary: String) -> Data {
       
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value  + lineBreak)")
          }
       }
       if let media = media {
          for photo in media {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
             body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
             body.append(photo.data)
             body.append(lineBreak)
          }
       }
       body.append("--\(boundary)--\(lineBreak)")
       return body
    }
    
    private func createDataBody(withParameters params: Data?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let data = params{
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=json_data\r\n\r\n".data(using: .utf8)!)
            body.append(data)
        }
        if let media = media {
           for photo in media {
              body.append("--\(boundary + lineBreak)")
              body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
              body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
              body.append(photo.data)
              body.append(lineBreak)
           }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
     }
    
    ///////////////////////////////////
    /////// Below is the code for AnyFile Uploads
    ///////////////////////////////////
   private func createBody(parameters:[String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }

        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        let content = body as Data
        print(content)
        return body as Data
    }
    
    
    private func UploadImageMethodCall(cJson:Data, endPoint:String)->APIMessage {
        let apiMessage = APIMessage()
        
        let todoEndpoint: String =  "\(baseURLString)\(endPoint)"
        guard let url = URL(string: todoEndpoint) else{
            apiMessage.ResponseCode = 209//error
            print("Error : cannot create URL")
            return apiMessage
        }
        let group = DispatchGroup()
        
        let params = ["user" : "abc"]
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = createBody(parameters: params,
                                         boundary: boundary,
                                         data: cJson,//UIImageJPEGRepresentation(chosenImage, 0.7)!,
                                         mimeType: "image/jpg",
                                         filename: "hello.jpg")
        
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("multipart/form-data",forHTTPHeaderField: "Accept")
        
        
        let session = URLSession.shared
        group.enter()
        let task = session.dataTask(with: urlRequest){
            
            (data, response, error) in
            
            guard error == nil else {
                
                print("error calling \(endPoint)")
                group.leave()
                print(error!)
                return
                
            }
            
            guard let responseData = data  else{
                
                print("error: did not recive data")
                group.leave()
                return
                
            }
            
            let rurl = (response as! HTTPURLResponse)
            apiMessage.ResponseCode = rurl.statusCode
            apiMessage.ResponseData = responseData
            
            apiMessage.ResponseMessage = String(data: data!, encoding: .utf8) ?? rurl.description
            
            group.leave()
        }
        task.resume()
        group.wait()
        return apiMessage
    }
}





//    extension UIImage{
//        func resizeImage(newWidth: CGFloat) -> UIImage {
//            let scale = newWidth / self.size.width
//            let newHeight = self.size.height * scale
//            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
//            self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
//            let newImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return newImage!
//
//        }
//    }
    

extension NSMutableData {
    
    
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
