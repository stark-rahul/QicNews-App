//
//  NewsAPIResponseLayer.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import Foundation

struct NewsAPIResponseLayer: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String? 
}
