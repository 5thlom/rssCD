//
//  Feeds.swift
//  rssCD
//
//  Created by Zhihua Yang on 10/30/14.
//  Copyright (c) 2014 Zhihua Yang. All rights reserved.
//

import Foundation
import CoreData

class Feeds: NSManagedObject {
    @NSManaged var desc: String
    @NSManaged var link: String
    @NSManaged var title: String


}
