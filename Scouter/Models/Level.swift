//
//  Level.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import SwiftyJSON

public class Level {
    
    var LevelID = 0
    var Name = ""
    var Abbr = ""
    var SortOrf = 0

    init(levelId: Int, name:String, abbr:String, sortOrf: Int) {
        LevelID = levelId
        Name = name
        Abbr = abbr
        SortOrf = sortOrf
    }
    
    class func build(json:JSON) -> Level {
        return Level(levelId: json["LevelID"].intValue,
                     name: json["Name"].stringValue,
                     abbr: json["Abbr"].stringValue,
                     sortOrf: json["SortOrf"].intValue)
    }
}
