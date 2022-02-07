//
//  ImageCell.swift
//  CityExplorer
//
//  Created by 吉郷景虎 on 2020/08/21.
//  Copyright © 2020 Kagetora Yoshigo. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageCell: Identifiable {
    let id = UUID()
    let image: Image
}


let samplePhotos = [
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto")),
    ImageCell(image: Image("samplePhoto"))
]
