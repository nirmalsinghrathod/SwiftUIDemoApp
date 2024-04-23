//
//  SongRowCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 50
    var imageName: String = Constant.randomImage
    var title: String = "Song Name"
    var subTitle: String = "Artist Name"
    
    var onEllipsisPress: (()-> Void)? = nil
    var onCellPress: (()-> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8){
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize,height: imageSize)
            
            VStack(alignment: .leading, spacing:5){
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                
                Text(subTitle)
                    .font(.callout)
                    .foregroundStyle(.spotifyLightGray)
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity,alignment: .leading)
            .onTapGesture {
                onCellPress?()
            }
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .onTapGesture {
                    onEllipsisPress?()
                }
        }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        SongRowCell()
    }
}
