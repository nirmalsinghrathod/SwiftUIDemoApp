//
//  BumbleChatView.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 11/04/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleChatView: View {
    @Environment(\.router) var router
    
    @State private var allUsers: [SpotifyUser] = []
    
    var body: some View {
        ZStack{
            Color.bumbleWhite.ignoresSafeArea()
            VStack{
                header
                    .padding(16)
                
                chatStatusView
                
                chatListView
                
                Spacer()
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private var chatStatusView: some View{
        VStack(alignment:.leading,
               content: {
            HStack(spacing:0){
                Text("Match Queue")
                Text(" (\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.leading,16)
            .frame(maxWidth: .infinity,alignment: .leading)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing:16){
                    ForEach(allUsers) { user in
                        BumbleProfileImageCell(
                            imageName: user.image,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random()
                        )
                    }
                }
                .padding(.leading,16)
            }
            .frame(height: 100)
            .scrollIndicators(.hidden)
        })
    }
    
    private var chatListView: some View{
        VStack(alignment:.leading,
               content: {
            HStack(spacing:0){
                Text("Chats")
                Text(" (Recent)")
                    .foregroundStyle(.bumbleGray)
                Spacer()
                Image(systemName: "line.horizontal.3.decrease")
                    .padding(.trailing, 16)
            }
            .padding(.leading,16)
            .frame(maxWidth: .infinity,alignment: .leading)
            
            ScrollView(.vertical) {
                LazyVStack(spacing:16){
                    ForEach(allUsers) { user in
                        BumbleChatPreviewCell(
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random(),
                            user: user,
                            isYourMove: Bool.random()
                        )
                    }
                }
                .padding(.leading,16)
            }
            .frame(maxHeight: .infinity)
            .scrollIndicators(.hidden)
        })
    }
    
    
    private var header: some View{
        HStack(spacing: 0){
            Image(systemName: "line.horizontal.3")
                .asButton(.press) {
                    router.dismissScreen()
                }
            Spacer()
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .fontWeight(.medium)
    }
    
    private func getData() async {
        
        do {
            allUsers = try await DataBaseHelper().getUsers()
        }catch{
            print(error)
        }
    }
}

#Preview {
    BumbleChatView()
}
