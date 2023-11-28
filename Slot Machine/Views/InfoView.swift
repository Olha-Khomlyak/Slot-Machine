//
//  InfoView.swift
//  Slot Machine
//
//  Created by A. Faruk Acar on 27.11.2023.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment:.center, spacing: 10) {
            LogoView()
            Spacer()
        
            Form {
                Section(header: Text("About the application")) {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platform", secondItem: "iPhone, iPad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Me")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.vertical,40)
        .overlay(alignment: .topTrailing) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.top,10)
                    .padding(.trailing,20)
            })
        }
    }
}

#Preview {
    InfoView()
}

struct FormRowView: View {
    
    var firstItem:String
    var secondItem:String
    
    var body: some View {
        HStack{
            Text(firstItem).foregroundColor(.gray)
            Spacer()
            Text(secondItem)
        }
    }
}
