//
//  APIManger.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/13.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class APIManger {

    static let shared = APIManger()
    private init() { }
    
    var jwtToken = ""


    //get요청
    func callGetRequest(baseEndPoint:BaseEndpoint, addPath:String?, completionHnadler: @escaping(JSON) -> ()) {
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("get 요청 성공")
                completionHnadler(json)
            
            // 호출 실패 시 처리 위함
            case .failure(let error):
                print(error)
                let json = JSON(error)
                print("get 요청 실패")
                completionHnadler(json)
                
            }
            
        }
        
    }
    
    //Post요청
    func callPostRequest(baseEndPoint:BaseEndpoint, addPath:String?, parameters: [String: Any], completionHnadler: @escaping(JSON) -> ()) {

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type": "application/json"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            debugPrint(response)
            switch response.result {
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                completionHnadler(json)
                print("post 요청 성공")

            case .failure(let error):
                print(error)
                let json = JSON(error)
                completionHnadler(json)
                print("post 요청 실패")
            }

        }

    }
    
    //로그인 Post요청
    func callLoginPostRequest(baseEndPoint:BaseEndpoint, addPath:String?, parameters: [String: String], completionHnadler: @escaping(JSON) -> ()) {

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            debugPrint(response)
            switch response.result {
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                completionHnadler(json)
                print("로그인 post 요청 성공")

            case .failure(let error):
                print(error)
                let json = JSON(error)
                completionHnadler(json)
                print("로그인 post 요청 실패")
            }

        }

    }
    
    //MultipartForm Post요청
    func callFormRequest(baseEndPoint:BaseEndpoint, addPath:String?, //formData: MultipartFormData,
                         dict: [String:Any], images: [UIImage], completionHnadler: @escaping(JSON) -> ()) {

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type": "multipart/form-data"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)
        
        AF.upload(multipartFormData: { (multipart) in
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                                print("JSON Data: \(jsonString)")
                            }
                multipart.append(jsonData, withName: "requestDto", mimeType: "application/json")
            }
            
            for image in images {
                let imageData = image.jpegData(compressionQuality: 0.8)!
                
                print("Image Data: \(imageData)")
                multipart.append(imageData, withName: "files", fileName: "image\(images.firstIndex(of: image)!+1).jpg", mimeType: "image/jpeg")
            }
            print(multipart)
            print(multipart.boundary)
            print(multipart.contentLength)
            print(multipart.contentType)
        }, to: url, method: .post, headers: headers).validate().responseJSON { response in
            debugPrint(response)
            switch response.result {

            case .success(let value):
                print(value)
                let json = JSON(value)
                completionHnadler(json)
                print("MultipartForm post 요청 성공")

            case .failure(let error):
                print(error)
                let json = JSON(error)
                completionHnadler(json)
                print("MultipartForm post 요청 실패")
            }

        }

    }


    //Delete요청
    func callDeleteRequest(baseEndPoint:BaseEndpoint, addPath:String?,parameters: [String: String]? ,completionHnadler: @escaping (JSON, Int) -> Void) {

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        print(url)

        AF.request(url, method: .delete, parameters:parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                print(value)
                let statusCode = response.response?.statusCode ?? 0
                print(statusCode)
                let json = JSON(value)
                completionHnadler(json, statusCode)
                print("delete 요청 성공")

            case .failure(let error):
                print(error)
                let json = JSON(error)
                print("delete 요청 실패", json)
            }
        }
    }


}
