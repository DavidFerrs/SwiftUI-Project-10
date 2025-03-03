//
//  FormsView.swift
//  CupcakeCorner
//
//  Created by David Ferreira on 02/03/25.
//

import SwiftUI

struct FormsView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Confirm") {
                    
                }
            }
            .disabled(disableForm)
        }
    }
}

#Preview {
    FormsView()
}
