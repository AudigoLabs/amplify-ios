//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

public struct IdentifyEntityMatchesResult: IdentifyResult {

    /// List of matched `EntityMatch`
    public let entities: [EntityMatch]

    public init(entities: [EntityMatch]) {
        self.entities = entities
    }
}
