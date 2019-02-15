//
//  ApiClient.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

class ApiClient {
    
    let apiKey = "AIzaSyC4Dp4jUCExPk_5z9m7_qTsQ_iR8zZaXwo"
    let channelId = "UCuTaETsuCOkJ0H_GAztWt0Q"
    
    enum APIError: Error {
        case serviceError
        case dataError
        case serverError(String)
    }
    
    
    func getComments(for videoId: String,completionHandler: @escaping([ItemDetail]?,Error?) -> Void){
        
        var components = URLComponents(string: "https://www.googleapis.com/youtube/v3/commentThreads")!
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "id", value: videoId),
            URLQueryItem(name: "key", value: apiKey)
        ]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        
        execute(urlRequest) { (data, error) in
            if let err = error {
                completionHandler(nil,err)
                return
            }
        }
    }

    
    func getVideoDetails(for videoId: String,completionHandler: @escaping([ItemDetail]?,Error?) -> Void){
        
        var components = URLComponents(string: "https://www.googleapis.com/youtube/v3/videos")!
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet,contentDetails"),
            URLQueryItem(name: "id", value: videoId),
            URLQueryItem(name: "key", value: apiKey)
        ]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        
        execute(urlRequest) { (data, error) in
            if let err = error {
                completionHandler(nil,err)
                return
            }
            guard let data = data else {
                completionHandler(nil,APIError.dataError)
                return
            }
            do {
                let rawDetailResponse = try JSONDecoder().decode(RawItemDetailResponse.self, from: data)
                completionHandler(rawDetailResponse.items, nil)
            } catch {
                completionHandler(nil, APIError.dataError)
            }
        }
        
    }
    
    func getVideos(completionHandler: @escaping([RawItem]?, Error?) -> Void) {
        
        var components = URLComponents(string: "https://www.googleapis.com/youtube/v3/search")!
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "channelId", value: channelId),
            URLQueryItem(name: "type", value: "video"),
            URLQueryItem(name: "order", value: "date"),
            URLQueryItem(name: "maxResults", value: "50"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        
        execute(urlRequest) { (data, error) in
            if let err = error {
                completionHandler(nil,err)
                return
            }
            guard let data = data else {
                completionHandler(nil,APIError.dataError)
                return
            }
            do {
                let rawServerResponse = try JSONDecoder().decode(RawServerResponse.self, from: data)
                completionHandler(rawServerResponse.items, nil)
            } catch {
                completionHandler(nil, APIError.dataError)
            }
        }
    }
    
    private func execute(_ urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.allHeaderFields)
                print(httpResponse.debugDescription)
            }
            
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completionHandler(nil, APIError.serviceError)
                return
            }
            guard let data = data, error == nil else {
                completionHandler(nil, APIError.serviceError)
                return
            }
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}
