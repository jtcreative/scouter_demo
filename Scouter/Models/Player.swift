//
//  Player.swift
//  Scouter
//
//  Created by James Timberlake on 3/5/18.
//  Copyright © 2018 James Timberlake. All rights reserved.
//

import SwiftyJSON

public class Player {

    var PlayerID = 0
    var LastName = ""
    var FirstName = ""
    var UsesName = ""
    var MiddleName = ""
    var Bats = 0
    var Throws = 0
    var TeamID = 0
    var BirthDate = ""
    var BirthCity = ""
    var BirthCountry = ""
    var BirthState = ""
    var Height = 0
    var Weight = 0
    var Position = 0
    var Number = 0
    var HeadShotUrl = ""
    var IsPitcher = false
    var FirstInitial = ""
    var LastInitial = ""
    var FullName = ""
    var FormalName = ""
    
    init(playerId:Int,
         lastName:String,
         firstName:String,
         usesName:String,
         middleName:String,
         bats:Int,
         throwNum:Int,
         teamId:Int,
         birthDate:String,
         birthCity:String,
         birthCountry:String,
         birthState:String,
         height:Int,
         weight:Int,
         position:Int,
         number:Int,
         headshotUrl:String,
         isPitcher:Bool,
         firstInitial:String,
         lastInitial:String,
         fullName:String,
         formalName:String) {
        PlayerID = playerId
        LastName = lastName
        FirstName = firstName
        UsesName = usesName
        MiddleName = middleName
        Bats = bats
        Throws = throwNum
        TeamID = teamId
        BirthDate = birthDate
        BirthCity = birthCity
        BirthCountry = birthCountry
        BirthState = birthState
        Height = height
        Weight = weight
        Position = position
        Number = number
        HeadShotUrl = headshotUrl
        IsPitcher = isPitcher
        FirstInitial = firstInitial
        LastInitial = lastInitial
        FullName = fullName
        FormalName = formalName
    }
    
    
    class func build(json:JSON) -> Player {
        return Player(playerId:json["PlayerID"].intValue,
                      lastName:json["LastName"].stringValue,
                      firstName:json["FirstName"].stringValue,
                      usesName:json["UsesName"].stringValue,
                      middleName:json["MiddleName"].stringValue,
                      bats:json["Bats"].intValue,
                      throwNum:json["Throws"].intValue,
                      teamId:json["TeamId"].intValue,
                      birthDate:json["BirthDate"].stringValue,
                      birthCity:json["BirthCity"].stringValue,
                      birthCountry:json["BirthCountry"].stringValue,
                      birthState:json["BirthState"].stringValue,
                      height:json["Height"].intValue,
                      weight:json["Weight"].intValue,
                      position:json["Position"].intValue,
                      number:json["Number"].intValue,
                      headshotUrl:json["HeadShotURL"].stringValue,
                      isPitcher:json["IsPitcher"].boolValue,
                      firstInitial:json["FirstInitial"].stringValue,
                      lastInitial:json["LastInitial"].stringValue,
                      fullName:json["FullName"].stringValue,
                      formalName:json["FormalName"].stringValue)
    }

}
