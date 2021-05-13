//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify

@available(iOS 13.0, *)
extension ReconcileAndLocalSaveOperation {
    struct Resolver {

        /// It's not absolutely required to make `resolve` a static, but it helps in two ways:
        /// 1. It makes it easier to avoid retain cycles, since the reducer can't close over the state machine's owning
        ///    instance
        /// 2. It helps enforce "pure function" behavior since `resolve` can only make decisions about the current state
        ///    and the action, rather than peeking out to some other state of the instance.
        static func resolve(currentState: State, action: Action) -> State {
            switch (currentState, action) {

            case (.waiting, .started(let remoteModel)):
                return .queryingPendingMutations(remoteModel)

            case (.queryingPendingMutations, .queriedPendingMutations(let remoteModel, let pendingMutations)):
                return .reconcilingWithPendingMutations(remoteModel, pendingMutations)

            case (.reconcilingWithPendingMutations, .dropped(let modelName)):
                return .notifyingDropped(modelName)

            case (.reconcilingWithPendingMutations, .reconciledWithPendingMutations(let remoteModel)):
                return .queryingLocalMetadata(remoteModel)

            case (.queryingLocalMetadata, .queriedLocalMetadata(let remoteModel, let localMetadata)):
                return .reconcilingWithLocalMetadata(remoteModel, localMetadata)

            case (.reconcilingWithLocalMetadata, .dropped(let modelName)):
                return .notifyingDropped(modelName)

            case (.reconcilingWithLocalMetadata, .reconciledAsApply(let remoteModel, let mutationType)):
                return .applyingRemoteModel(remoteModel, mutationType)

            case (.applyingRemoteModel, .applied(let savedModel, let mutationType)):
                return .notifying(savedModel, mutationType)

            case (.notifyingDropped, .notified):
                return .finished

            case (.notifying, .notified):
                return .finished

            case (_, .errored(let amplifyError)):
                return .inError(amplifyError)

            case (.finished, _):
                return .finished

            default:
                log.warn("Unexpected state transition. In \(currentState), got \(action)")
                return currentState
            }

        }

    }
}
