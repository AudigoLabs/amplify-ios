//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SQLite

/// Represents a `insert` SQL statement associated with a `Model` instance.
public struct InsertStatement: SQLStatement {
    public let modelSchema: ModelSchema
    public let variables: [Binding?]

    public init(model: Model, modelSchema: ModelSchema) {
        self.modelSchema = modelSchema
        self.variables = model.sqlValues(for: modelSchema.columns, modelSchema: modelSchema)
    }

    public var stringValue: String {
        let fields = modelSchema.columns
        let columns = fields.map { $0.columnName() }
        var statement = "insert into \"\(modelSchema.name)\" "
        statement += "(\(columns.joined(separator: ", ")))\n"

        let variablePlaceholders = Array(repeating: "?", count: columns.count).joined(separator: ", ")
        statement += "values (\(variablePlaceholders))"

        return statement
    }
}
