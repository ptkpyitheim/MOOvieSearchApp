//
//  APIResults.swift
//  MovieSearchingApp
//
//  Created by Pyi Theim Kyaw on 10/20/18.
//  Copyright © 2018 Pyi Theim Kyaw. All rights reserved.
//

import Foundation

struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
} 
