//
//  File.swift
//  RouteContextApp
//
//  Created by Tomas Martins on 12/09/2018.
//  Copyright © 2018 Tomas Martins. All rights reserved.
//

import Foundation

class Route {
    var name: String
    var sourceLat: String
    var sourceLon: String
    var destinationLat: String
    var destinationLon: String
    var playlists: [String]
    var phoneContacts: String
    
    init(routeName: String, srcLatitude: String, srcLongitude: String, dstLatitude: String, dstLongitude: String, selectedPlaylists: [String], contacts: String) {
        self.name = routeName
        self.sourceLat = srcLatitude
        self.sourceLon = srcLongitude
        self.destinationLat = dstLatitude
        self.destinationLon = dstLongitude
        self.playlists = selectedPlaylists
        self.phoneContacts = contacts
    }
}
