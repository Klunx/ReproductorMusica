//
//  SongObj.swift
//  ReproductorMusica
//
//  Created by Fernando Renteria Correa on 10/04/2016.
//  Copyright © 2016 Fernando Renteria Correa. All rights reserved.
//

import Foundation

class SongObj {
    
    var songName: String = "";
    var imgSong: String = "";
    var songPath: String = "";
    var songExt: String = "";
    
    init() {}
    
    init (songName: String, imgSong: String, songPath: String, songExt: String) {
        self.songName = songName
        self.imgSong = imgSong
        self.songPath = songPath
        self.songExt = songExt
    }
}