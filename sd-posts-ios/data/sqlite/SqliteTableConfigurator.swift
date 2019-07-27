//
//  SqliteTableConfigurator.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/27/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation
import GRDB

public protocol SqliteTableConfigurator {
    static func config(tableDefinition: TableDefinition)
}
