//
//  BumbleHomeView.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {
    @Environment(\.router) var router
    @State private var options: [String] = ["Everyone","Trending"]
    @AppStorage("bumble_home_filter") private var selection: String = "Everyone"
    
    @State private var allUsers: [SpotifyUser] = []
    @State private var selectedIndex: Int = 0
    @State private var currentoffset: CGFloat = 0
    @State private var cardOffsets: [Int:Bool] = [:] // User Id is key
    
    
    var body: some View {
        ZStack{
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing:12){
                header
                BumbleFilterView(options: options, selection: selection)
                    .background(Divider(),alignment:.bottom)
                
                profileView
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var profileView: some View{
        ZStack{
            if !allUsers.isEmpty{
                ForEach(Array(allUsers.enumerated()),id:\.offset) { (index,user) in
                    
                    
                    let isPrevious = (selectedIndex - 1) == index
                    let isCurrent = selectedIndex == index
                    let isNext = (selectedIndex + 1) == index
                    
                    if isPrevious || isCurrent || isNext{
                        let offsetValue = cardOffsets[user.id]
                        
                        BumbleCardView(
                            user: user,
                            onXmarkPress:{
                                userDidSelect(index: index, islike: false)
                        },
                            onCheckmarkPress: {
                                userDidSelect(index: index, islike: true)
                        })
                            .withDragGesture(
                                .horizontal,
                                minimumDistance: 10,
                                resets: true,
                                rotationMultiplier: 1.05,
                                onChanged: { dragOffset in
                                    currentoffset = dragOffset.width
                                },
                                onEnded: { dragOffset in
                                    if dragOffset.width < -50{
                                        userDidSelect(index: index, islike: false)
                                    }else if dragOffset.width > 50{
                                        userDidSelect(index: index, islike: true)
                                    }
                                }
                            )
                            .zIndex(Double(allUsers.count - index))
                            .offset(x:offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                    }
                }
            }else{
                ProgressView()
            }
            
            overlaySwipeIndecatore
            .zIndex(999999)
        }
        .frame(maxHeight: .infinity)
        .animation(.smooth, value: cardOffsets)
    }
    
    private func userDidSelect(index: Int, islike:Bool){
        let user = allUsers[index]
        cardOffsets[user.id] = islike
        
        selectedIndex += 1
    }
    
    private func getData() async {
        
        do {
            allUsers = try await DataBaseHelper().getUsers()
            
            
        }catch{
            print(error)
        }
    }
    
    
    private var overlaySwipeIndecatore: some View{
        ZStack{
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentoffset) > 100 ? 1.3 : 1.0)
                .offset(x: min(-currentoffset,150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment:.leading)
            
            
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentoffset) > 100 ? 1.3 : 1.0)
                .offset(x: max(-currentoffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentoffset)
    }
    
    private var header: some View{
        HStack(spacing:0){
            HStack(spacing:0){
                Image(systemName: "bubble")
                    .padding(8)
                    .offset(y:3)
                    .asButton(.press) {
                        router.showScreen(.push) { _ in
                            BumbleChatView()
                        }
                    }
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .asButton(.press) {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .asButton(.press) {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundColor(.bumbleBlack)
    }
    
    
}

#Preview {
    BumbleHomeView()
}
