//
//  PlayListDescriptionCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI
import SwiftfulUI

struct PlayListDescriptionCell: View {
    
    var description: String = Product.mockProduct.description
    var userName: String = "Nirmal"
    var subHeadline: String = "Some Headline goes here"
    var onAddtoPress: (()-> Void)? = nil
    var onSharePress: (()-> Void)? = nil
    var onEllipsesPress: (()-> Void)? = nil
    var onDownLoadPress: (()-> Void)? = nil
    var onShuffledPress: (()-> Void)? = nil
    var onPlayPress: (()-> Void)? = nil
    
    
    var body: some View {
        VStack(alignment: .leading,spacing: 9, content: {
            Text(description)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity,alignment: .leading)
                .lineLimit(3)
            
            madeForYouSection
            
            Text(subHeadline)
            
            buttonRows

        })
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }
    
    private var madeForYouSection: some View{
        HStack(spacing: 8, content: {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundColor(.spotifyGreen)
            
            Text("Made For \(userName)")
                .foregroundStyle(.spotifyWhite)
                .bold()
        })
    }
    
    
    private var buttonRows: some View{
        HStack(spacing: 0, content: {
            HStack(spacing: 0, content: {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .asButton(.press) {
                        
                    }
                
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .asButton(.press) {
                        
                    }
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .asButton(.press) {
                        
                    }
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .asButton(.press) {
                        
                    }
            })
            .offset(x: -8)
            
            Spacer()
            
            HStack(spacing: 8,content: {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .background(Color.black.opacity(0.001))
                    .asButton(.press) {
                        
                    }
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 24))
                    .background(Color.black.opacity(0.001))
                    .asButton(.press) {
                        
                    }
            })
            .foregroundStyle(.spotifyGreen)
            
        })
        .font(.title2)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        PlayListDescriptionCell()
            .padding()
    }
}
