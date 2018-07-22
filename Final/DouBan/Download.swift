//
//  Download.swift
//  Final
//
//  Created by 樊佳亮 on 2018/6/20.
//  Copyright © 2018年 樊佳亮. All rights reserved.
//

import Foundation

class Download{
    var music:Music
    init (music:Music){
        self.music=music
    }
    
    var task:URLSessionDownloadTask?
    var isDownloading=false
    
    var resumeData: Data?
    
    //Download delegate
    
    var progress:Float=0
    
    
    
}
