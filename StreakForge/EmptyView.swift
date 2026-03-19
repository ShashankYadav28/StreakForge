//
//  EmptyView.swift
//  StreakForge
//
//  Created by Shashank Yadav on 19/03/26.
//

import SwiftUI

struct HabitEmptyView: View {
    var body: some View {
        Spacer()
        VStack(spacing: 10){
            Text("No Habits Yet")
                .font(.title)
                .fontWeight(.medium)
            Text("Tap + to add Habit ")
                .font(.title3)
            Image(systemName: "tray")
                .font(.system(size: 60))
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
        Spacer()
    }
}

#Preview {
    HabitEmptyView()
}
