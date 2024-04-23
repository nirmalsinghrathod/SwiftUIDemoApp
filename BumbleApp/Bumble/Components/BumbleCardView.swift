//
//  BumbleCardView.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    
    var user: SpotifyUser = .mockUser
    var onSupperLikedPress:(()-> Void)? = nil
    var onXmarkPress:(()-> Void)? = nil
    var onCheckmarkPress:(()-> Void)? = nil
    var onSendComplimentPress:(()-> Void)? = nil
    var onHideAndReportPress:(()-> Void)? = nil
    
    @State private var cardFrame:CGRect = .zero
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing:0){
                headerView
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                    .padding([.horizontal,.vertical], 24)
                
                myInterest
                    .padding([.horizontal,.vertical], 24)
                
                ForEach(User.mockUser.images, id: \.self){ image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                myLoaction
                    .padding([.horizontal,.vertical], 24)
                
                footerSection
                    .padding([.top,.bottom],50)
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(alignment: .bottomTrailing, content: {
            Image(systemName: "hexagon.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 60))
                .overlay {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.bumbleBlack)
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                }
                .padding(24)
        })
        .cornerRadius(32)
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    private var footerSection: some View{
        VStack(spacing: 24){
            HStack(spacing:0){
                Circle()
                    .fill(.bumbleYellow)
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .asButton(.press) {
                        onXmarkPress?()
                    }
                
                Spacer()
                
                Circle()
                    .fill(.bumbleYellow)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 60, height: 60)
                    .asButton(.press) {
                     onCheckmarkPress?()
                    }
            }
            .padding(.horizontal,24)
            
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .asButton(.press) {
                    onHideAndReportPress?()
                }
        }
    }
    
    private var myLoaction: some View{
        VStack(alignment:.leading, spacing: 12){
            HStack(spacing:8){
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Loaction")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            
            
            Text("10 KM away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            InterestPillView(iconName: nil,emoji: "🇮🇳", name: "Live in India")
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var myInterest: some View{
        VStack(alignment: .leading,spacing: 12){
            VStack(alignment: .leading,spacing: 8){
                sectionTitle(title: "My Basics")
                InterestPillGridVIew(intrest: User.mockUser.basics)
            }
            VStack(alignment: .leading,spacing: 8){
                sectionTitle(title: "My Interests")
                InterestPillGridVIew(intrest: User.mockUser.interests)
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var aboutMeSection: some View{
        VStack(alignment: .leading,spacing: 12, content: {
            sectionTitle(title: "About Me")
            
            Text(User.mockUser.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing:0){
                BumbleHeartView()
                
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal,.leading],8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            .asButton(.press) {
                onSendComplimentPress?()
            }
        })
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var headerView: some View{
        ZStack(alignment:.bottomLeading){
            ImageLoaderView(urlString: user.image)
            
            VStack(alignment:.leading, spacing: 8){
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8){
                    Image(systemName: "suitcase")
                    Text(User.mockUser.work)
                }
                
                HStack(spacing: 8){
                    Image(systemName: "graduationcap")
                    Text(User.mockUser.education)
                }
                
                BumbleHeartView()
                    .asButton(.press) {
                        onSupperLikedPress?()
                    }
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity,alignment:.leading)
            .background(
                LinearGradient(
                    colors: [.bumbleBlack.opacity(0),
                             .bumbleBlack.opacity(0.6),
                             .bumbleBlack.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
    
    private func sectionTitle(title: String)-> some View{
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
}

#Preview {
    BumbleCardView()
        .padding(.horizontal,16)
        .padding(.vertical,40)
}
