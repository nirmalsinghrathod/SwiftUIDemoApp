//
//  BumbleFilterView.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI

struct BumbleFilterView: View {
    
    var options: [String] = ["Everyone","Trending"]
    @State  var selection: String
    @Namespace private var namespace
    
    var body: some View {
        HStack(alignment: .top,spacing: 32){
            ForEach(options,id: \.self){ option in
                VStack(spacing: 8){
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    if selection == option{
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
                .padding(.top,8)
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value: selection)
    }
}

fileprivate struct BumbleFilterViewPrivew: View {
    var options: [String] = ["Everyone","Trending"]
    @State private var selection: String = "Everyone"
    
    var body: some View {
        BumbleFilterView(options: options, selection: selection)
    }
}

#Preview {
    BumbleFilterViewPrivew()
        .padding()
}
