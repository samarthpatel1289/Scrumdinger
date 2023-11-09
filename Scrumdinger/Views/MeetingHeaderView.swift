//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Samarth Patel on 11/8/23.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondElapsed : Int
    let secondRemaining : Int
    let theme : Theme
    private var totalSeconds : Int {
        return secondElapsed + secondRemaining
    }
    private var progress:Double {
        guard totalSeconds > 0 else {return 1}
        return Double(secondElapsed)/Double(secondRemaining)
    }
    private var minutesRemaining: Int{
        return secondRemaining / 60
    }
    var body: some View {
        VStack{
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme:theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview {
    MeetingHeaderView(secondElapsed: 300, secondRemaining: 600, theme: .bubblegum)
        .previewLayout(.sizeThatFits)
}
