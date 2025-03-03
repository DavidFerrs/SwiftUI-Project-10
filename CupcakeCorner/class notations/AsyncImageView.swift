//
//  AsyncImageView.swift
//  CupcakeCorner
//
//  Created by David Ferreira on 02/03/25.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
        // Adjust the scale
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        // Load and put in frame
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 200, height: 200)
        
        // Load, treat erros and put in frame
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    AsyncImageView()
}
