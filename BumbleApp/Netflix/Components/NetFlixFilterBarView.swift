//
//  NetFlixFilterBarView.swift
//  BumbleApp
//
//  Created by Hemant Singh Rajput on 21/04/24.
//

import SwiftUI

struct FilterModel: Hashable,Equatable{
    let title: String
    let isDropdown: Bool
    
    static var mockArray: [FilterModel]{
        [
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: false),
            FilterModel(title: "Categories", isDropdown: true)
        ]
    }
        
}

struct NetFlixFilterBarView: View {
    
    var filters: [FilterModel] = FilterModel.mockArray
    var isSelected: FilterModel? = nil
    var onFilterPressed: ((FilterModel)-> Void)? = nil
    var onXmarkPressed: (()-> Void)? = nil
    
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                if isSelected != nil{
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(content: {
                            Circle()
                                .stroke(lineWidth: 1)
                        })
                        .foregroundStyle(.netflixLightGray)
                        .background(.netflixBlack.opacity(0.001))
                        .onTapGesture {
                            onXmarkPressed?()
                        }
                        .transition(.move(edge: .leading))
                        .padding(.leading,16)
                }
                
                
                ForEach(filters,id: \.self){ filter in
                    if isSelected == nil || isSelected == filter{
                        NetFlixFilterCell(
                            title: filter.title,
                            isDropDown: filter.isDropdown,
                            isSelected: isSelected == filter
                        )
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading,((isSelected == nil) && filter == filters.first) ? 16:0)
                    }
                }
            }
            .padding(.vertical,4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy,value: isSelected)
    }
}

#Preview {
    NetFlixFilterBarView()
}
