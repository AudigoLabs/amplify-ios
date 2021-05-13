//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import AWSPluginsCore
@testable import AWSDataStoreCategoryPlugin

extension RemoteSyncReconciler.Disposition: Equatable {
    public static func == (lhs: RemoteSyncReconciler.Disposition,
                           rhs: RemoteSyncReconciler.Disposition) -> Bool {
        switch (lhs, rhs) {
        case (.applyRemoteModel(let rm1, let mutationType1), .applyRemoteModel(let rm2, let mutationType2)):
            return rm1.model.id == rm2.model.id &&
                rm1.model.modelName == rm2.model.modelName &&
                mutationType1 == mutationType2
        case (.dropRemoteModel, .dropRemoteModel):
            return true
        default:
            return false
        }
    }
}

extension ReconcileAndLocalSaveOperation.Action: Equatable {
    public static func == (lhs: ReconcileAndLocalSaveOperation.Action,
                           rhs: ReconcileAndLocalSaveOperation.Action) -> Bool {
        switch (lhs, rhs) {
        case (.started(let model1), .started(let model2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
        case (.queriedPendingMutations(let model1, let pendingMutations1),
              .queriedPendingMutations(let model2, let pendingMutations2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
                && pendingMutations1 == pendingMutations2
        case (.reconciledWithPendingMutations(let model1), .reconciledWithPendingMutations(let model2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
        case (.queriedLocalMetadata(let model1, let localmetadata1), .queriedLocalMetadata(let model2, let localmetadata2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
                && localmetadata1 == localmetadata2
        case (.reconciledAsApply(let model1, let mutationEvent1), .reconciledAsApply(let model2, let mutationEvent2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
                && mutationEvent1 == mutationEvent2
        case (.applied(let model1, let mutationEvent1), applied(let model2, let mutationEvent2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
                && mutationEvent1 == mutationEvent2
        case (.dropped, dropped):
            return true
        case (.notified, .notified):
            return true
        case (.cancelled, .cancelled):
            return true
        case (.errored(let error1), .errored(let error2)):
            return error1.errorDescription == error2.errorDescription
        default:
            return false
        }
    }
}

extension ReconcileAndLocalSaveOperation.State: Equatable {
    public static func == (lhs: ReconcileAndLocalSaveOperation.State,
                           rhs: ReconcileAndLocalSaveOperation.State) -> Bool {
        switch (lhs, rhs) {
        case (.waiting, .waiting):
            return true
        case (.queryingPendingMutations(let model1), .queryingPendingMutations(let model2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
        case (.queryingLocalMetadata(let model1), .queryingLocalMetadata(let model2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
        case (.applyingRemoteModel(let model1, let mutationEvent1), .applyingRemoteModel(let model2, let mutationEvent2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
                && mutationEvent1 == mutationEvent2
        case (.notifying(let model1, let existsLocally1), .notifying(let model2, let existsLocally2)):
            return model1.model.id == model2.model.id
                && model1.model.modelName == model2.model.modelName
                && existsLocally1 == existsLocally2
        case (.finished, .finished):
            return true
        case (.inError(let error1), .inError(let error2)):
            return error1.errorDescription == error2.errorDescription
        default:
            return false
        }
    }
}

extension ModelSyncedEvent: Equatable {
    public static func == (lhs: ModelSyncedEvent, rhs: ModelSyncedEvent) -> Bool {
        return lhs.modelName == rhs.modelName
            && lhs.isFullSync == rhs.isFullSync
            && lhs.isDeltaSync == rhs.isDeltaSync
            && lhs.added == rhs.added
            && lhs.updated == rhs.updated
            && lhs.deleted == rhs.deleted
    }
}

extension MutationSyncMetadata: Equatable {
    public static func == (lhs: MutationSyncMetadata, rhs: MutationSyncMetadata) -> Bool {
        return lhs.id == rhs.id
            && lhs.deleted == rhs.deleted
            && lhs.lastChangedAt == rhs.lastChangedAt
            && lhs.version == rhs.version
    }
}

extension MutationEvent: Equatable {
    public static func == (lhs: MutationEvent, rhs: MutationEvent) -> Bool {
        return lhs.id == rhs.id
            && lhs.modelId == rhs.modelId
            && lhs.modelName == rhs.modelName
            && lhs.json == rhs.json
            && lhs.mutationType == rhs.mutationType
            && lhs.createdAt == rhs.createdAt
            && lhs.version == rhs.version
            && lhs.inProcess == rhs.inProcess
            && lhs.graphQLFilterJSON == rhs.graphQLFilterJSON
    }
}
