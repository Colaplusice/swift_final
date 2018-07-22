//
//  Music.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/20.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import Foundation

class Music {
    
    let name:String
    let artist:String
    
    let image_url:String

    let play_url:String
    init(name:String,artist:String,image_url:String,play_url:String) {
        self.name=name
        self.artist=artist
        self.image_url=image_url
        self.play_url=play_url
    }
}
