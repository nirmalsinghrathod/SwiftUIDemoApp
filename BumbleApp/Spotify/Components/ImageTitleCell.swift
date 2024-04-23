//
//  ImageTitleCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI

struct ImageTitleCell: View {
    var imageSize: CGFloat = 100
    var imageName: String = Constant.randomImage
    var title: String = "Some Song Name"
    
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8){
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize,height: imageSize)
            
            Text(title)
                .font(.callout)
                .lineLimit(2)
                .foregroundStyle(.spotifyLightGray)
            
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        ImageTitleCell()
    }
}
