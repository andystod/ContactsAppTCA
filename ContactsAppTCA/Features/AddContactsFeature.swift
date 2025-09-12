//
//  AddContactsFeature.swift
//  ContactsAppTCA
//
//  Created by Andrew Stoddart on 9/12/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AddContactsFeature {
    @ObservableState
    struct State {
        var contact: Contact
    }
    enum Action {
        case cancelButtonTappped
        case saveButtonTapped
        case setName(String)
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTappped:
                return .none
            case .saveButtonTapped:
                return .none
            case .setName(let name):
                state.contact.name = name
                return .none
            }
        }
    }
}

struct AddContactsFeatureView: View {
    @Bindable var store: StoreOf<AddContactsFeature>

    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
        }
    }
}

#Preview {
    AddContactsFeatureView(store: Store(initialState: AddContactsFeature.State(contact: Contact(id: UUID(), name: "Pat"))) {
        AddContactsFeature()
    })
}
