//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Samarth Patel on 11/8/23.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""
    var body: some View {
        Form{
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack{
                    Slider(
                        value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1
                    ){
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Attendes")){
                ForEach(scrum.attendees){
                    attendees in Text(attendees.name)
                }
                .onDelete{
                    indices in scrum.attendees.remove(atOffsets: indices)
                }
                HStack{
                    TextField(
                        "New Attendees",
                        text: $newAttendeeName
                    )
                    Button(action: {
                        withAnimation{
                            let attendees = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendees)
                            newAttendeeName = ""
                        
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider{
    static var previews: some View{
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
