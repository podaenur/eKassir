//
//  APIRequestFactory.swift
//  eKassir
//
//  Created by Evgeniy Akhmerov on 19/12/16.
//  Copyright © 2016 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

struct APIRequestFactory {
    typealias RequestSettings = (urlString: String, fileName: String)
    
    //MARK: - Public
    
    static func requestData() -> URLRequest {
        return request(for: ("DATA_URL", "orders.json"))
    }
    
    static func requestIcon(name: String) -> URLRequest {
        return request(for: ("IMAGE_URL", name))
    }
    
    //MARK: - Private
    
    private static func request(for settings: RequestSettings) -> URLRequest {
        let urlString = Bundle.main.object(forInfoDictionaryKey: settings.urlString) as! String
        let url = URL(string: urlString)!.appendingPathComponent(settings.fileName)
        return URLRequest(url: url)
    }
}
