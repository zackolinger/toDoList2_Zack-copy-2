//
//  SetUp.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/11/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import Foundation


                    /* AdMob Settings */
/**
 1_ AdMob in default are disabled  ENABLE_ADMOB = false
        *to activate it replace false to true
        *to deactivate it replace true to false
 2- Type your Banner AdMob ID between the quotation mark of the variable ADMOB_BANNER_ID
 3- Type your Interstitial AdMob ID between the quotation mark of the variable ADMOB_INTERSTITIAL_ID */

let ENABLE_ADMOB = true
let ADMOB_BANNER_ID = "ca-app-pub-8964973200415729/1051961491"
let ADMOB_INTERSTITIAL_ID = "ca-app-pub-8964973200415729/2982693097"
//=========================================================================================

                                /* Sound Settings */
/** 
 1- First Step of Adding New Sounds Is To Drag MP3 files to the Folder Sounds.
 2- The folder Sounds is located on the top left after maximazing the blue icon toDoList2
 3- After Dragging the files to the Sounds folder
 4- Type the name of the added mp3 file between the quotation mark down */

let ADD_TASK_SOUND = "shineDingAddTask"
let DELETE_TASK_SOUND = "whipWhooshSwooshDelete"
let ACHIEVING_TASK_SOUND = "magicSpellWithHarpAchieving"
let UNACHIEVING_TASK_SOUND = "unAchievingDisapointment"
//=========================================================================================

                                /* Color Settings */
/**
 1- Get the hex value of the color you want to add to the app
 2- Copy what is inside these paranthesis  ( ,"" ) / Paste your color hex value between the quotation Mark
 3- Paste it to the very End of the array , before ( ] )
 Ex:   ( , "YOUR_HEX_VALUE" ) */

let COLORS: [String] = [
    
/*DEFAULTCOLOR:*/"#5890DB",
/*"blueColor":*/"#B0EAFF",
/*"La Salle GreenColor":*/"#007A33",
/*"purpleColor":*/"#E7C3FF",
/*"pinkColor":*/"#E3A6B6",
/*"lightBrownColor":*/"#ECDAD2",
/*"Wood Brown Color":*/"#BA9D71",
/*"Mellow Yellow Color":*/"#F7D579",
/*"Moordant Red 19 Color":*/"#A90E0E"
    
]
//=========================================================================================

