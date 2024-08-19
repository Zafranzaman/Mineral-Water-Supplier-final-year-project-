//
//  NetworkHelper.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 20/02/2023.
//

import Foundation
import Alamofire
//struct MyModel: Codable {
//    let userID, id: Int?
//    let title: String?
//    let completed: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
//        case id, title, completed
//    }
//}

let baseUrl = "http://192.168.250.48/FypFinalApi/api/"

typealias CallResponse<T> = ((Result<T, Error>) -> Void)?

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(_ endPoint: String,
                               decoder: T.Type,
                               method: HTTPMethod,
                               parameters: Parameters?,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: HTTPHeaders?,
                               completion: CallResponse<T>) {
        
        let url = baseUrl + endPoint
        var header = headers
        if headers == nil {
            header = HTTPHeaders()
        }
        
        header?.add(name: "Content-Type", value: "application/json")
        header?.add(name: "Accept", value: "application/json")
        header?.add(name: "language", value: "en")
        
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: header)
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let value):
                completion?(.success(value))
            }
            
        }
    }
    
    
    func uploadImage<T: Decodable>(endPoint: String,
                                   decoder: T.Type,
                                   image: UIImage,
                                   imageName: String,
                                   parameters: Parameters?,
                                   headers: HTTPHeaders?,
                                   completion: CallResponse<T>) {
        
        let url = baseUrl + endPoint
        var header = headers
        if headers == nil {
            header = HTTPHeaders()
        }
        
        header?.add(name: "Content-Type", value: "multipart/form-data")
        header?.add(name: "Accept", value: "application/json")
        header?.add(name: "language", value: "en")
   
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "file", fileName: imageName, mimeType: "image/jpeg")
            }
            if let parameters = parameters {
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
        }, to: url, method: .post, headers: header)
        .uploadProgress(closure: { progress in
            //progress will show how much data uploaded on the server.
            print(progress)
        })
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let value):
                completion?(.success(value))
            }
        }
    }

    func howToCallUploadImage(){
//        NetworkManager.shared.uploadImage(endPoint:"user/profile", decoder: UploadImageResponse.self, image: T##UIImage, imageName: "ImageName + userID (ForExample profie_picture_12", parameters: <#T##Parameters?#>, headers: <#T##HTTPHeaders?#>, completion: <#T##CallResponse<T>#>)
    }
    
}
