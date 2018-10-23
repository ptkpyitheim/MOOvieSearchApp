//
//  Movie.swift
//  MovieSearchingApp
//
//  Created by Pyi Theim Kyaw on 10/20/18.
//  Copyright © 2018 Pyi Theim Kyaw. All rights reserved.
//

import Foundation


struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count:Int!
} 
