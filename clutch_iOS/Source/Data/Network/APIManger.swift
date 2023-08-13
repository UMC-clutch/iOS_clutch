//
//  APIManger.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/13.
//

import Alamofire
import SwiftyJSON
import Foundation

class APIManger {

    static let shared = APIManger()
    private init() { }
    
    let jwtToken = "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImR3cnl1MzA3OUBnbWFpbC5jb20iLCJuYW1lIjoi66WY64-Z7JmEIiwiaWF0IjoxNjkxOTMwMjEyLCJ0eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkxOTMyMDEyfQ.62QHbv8zsmtypIJu9Al9cq3p1CI35jamV_ElJX3PhWU"


    //get요청
    func callGetRequest(baseEndPoint:BaseEndpoint, addPath:String?, completionHnadler: @escaping(JSON) -> ()) {
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
    
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("get 요청 성공")
                completionHnadler(json)
                
            case .failure(let error):
                print(error)
                print("get 요청 실패")
                
            }
            
        }
        
    }
    
    //Post요청
    func callPostRequest(baseEndPoint:BaseEndpoint, addPath:String?, parameters: [String: String], completionHnadler: @escaping(JSON) -> ()) {

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)",
            "Content-Type": "application/json"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath


        AF.request(url, method: .post, parameters: parameters,headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHnadler(json)
                print("post 요청 성공")

            case .failure(let error):
                print("post 요청 실패")

            }

        }

    }

    //Delete요청
    func callDeleteRequest(baseEndPoint:BaseEndpoint, addPath:String?, completion: @escaping (Result<JSON, Error>) -> Void) {

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(jwtToken)"
        ]

        guard let addPath = addPath else { return }
        let url = baseEndPoint.requestURL + addPath

        AF.request(url, method: .delete, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(.success(json))
                print("delete 요청 성공")

            case .failure(let error):
                completion(.failure(error))
                print("delete 요청 실패")
            }
        }
    }


}


