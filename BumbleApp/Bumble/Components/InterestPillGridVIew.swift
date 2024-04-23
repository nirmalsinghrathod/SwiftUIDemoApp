//
//  InterestPillGridVIew.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI
import SwiftfulUI

struct InterestPillGridVIew: View {
    
    var intrest: [UserInterest] = User.mockUser.interests
    
    var body: some View {
        ZStack{
            NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8, items: intrest) { intrests in
                if let intrests{
                    InterestPillView(
                        iconName: intrests.iconName,
                        emoji: intrests.emoji,
                        name: intrests.name
                    )
                }else{
                    EmptyView()
                }
                    
            }
        }
    }
}

#Preview {
    InterestPillGridVIew()
}
