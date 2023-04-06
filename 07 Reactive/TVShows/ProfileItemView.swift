//
//  ProfileItemView.swift
//  TVShows
//
//  Created by Igor Rosocha on 22.03.2023.
//

import SwiftUI

struct ProfileItemView: View {
    
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 20
    
    let imageName: String
    let text: String?
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: iconSize, height: iconSize)
            
            Text(text ?? "-")
                .fontWeight(.light)
        }
    }
}

struct ProfileItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileItemView(
            imageName: "person.crop.circle",
            text: "igor.rosocha"
        )
        
    }
}
