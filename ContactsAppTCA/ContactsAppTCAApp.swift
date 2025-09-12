//
//  ContactsAppTCAApp.swift
//  ContactsAppTCA
//
//  Created by Andrew Stoddart on 9/12/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct ContactsAppTCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContactsView(store: Store(initialState: ContactsFeature.State()) {
                ContactsFeature()
            })
        }
    }
}
