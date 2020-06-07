//
//  ContentView.swift
//  TinderUIPoC
//
//  Created by 板垣智也 on 2020/06/06.
//  Copyright © 2020 板垣智也. All rights reserved.
//

import SwiftUI

//struct Kitten: Hashable, CustomStringConvertible {
//    var id: Int
//
//    let name: String
//    let age: Int
//    let mutualFriends: Int
//    let imageName: String
//    let occupation: String
//
//    var description: String {
//        return "\(name), id: \(id)"
//    }
//}

struct ContentView: View {
    /// List of kitten

    @State var kittens: [Kitten] = 
//         [
//        Kitten(id: 0, name: "Cindy", age: 1, mutualFriends: 4, imageName: "1", occupation: "Coach"),
//        Kitten(id: 1, name: "Mark", age: 1, mutualFriends: 0, imageName: "2", occupation: "Insurance Agent"),
//        Kitten(id: 2, name: "Clayton", age: 1, mutualFriends: 1, imageName: "3", occupation: "Food Scientist"),
//        Kitten(id: 3, name: "Brittni", age: 1, mutualFriends: 4, imageName: "4", occupation: "Historian"),
//        Kitten(id: 4, name: "Archie", age: 1, mutualFriends:18, imageName: "5", occupation: "Substance Abuse Counselor"),
//        Kitten(id: 5, name: "James", age: 1, mutualFriends: 3, imageName: "6", occupation: "Marketing Manager"),
//        Kitten(id: 6, name: "Danny", age: 1, mutualFriends: 16, imageName: "7", occupation: "Dentist"),
//        Kitten(id: 7, name: "Chi", age: 1, mutualFriends: 9, imageName: "8", occupation: "Recreational Therapist"),
//        Kitten(id: 8, name: "Josue", age: 1, mutualFriends: 5, imageName: "9", occupation: "HR Specialist"),
//        Kitten(id: 9, name: "Debra",age: 1, mutualFriends: 13, imageName: "10", occupation: "Judge")
//    ]
    
    /// Return the CardView's width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current kitten
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(kittens.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    /// Return the CardView's frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current kitten
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(kittens.count - 1 - id) * 10
    }
    
    private var maxID: Int {
        return self.kittens.map{ $0.id }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                // colorLiteralがカラーボックスに変換される
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7803921569, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                VStack(spacing: 24) {
                    DateView()
                    ZStack {
                        ForEach(self.kittens, id: \.self) { kitten in
                            Group {
                                // Range Operator
                                if (self.maxID - 3)...self.maxID ~= kitten.id {
                                    CardView(kitten: kitten, onRemove: { removedKitten in
                                        // Remove that kitten from our array
                                        self.kittens.removeAll { $0.id == removedKitten.id }
                                    })
                                        .animation(.spring())
                                        .frame(width: self.getCardWidth(geometry, id: kitten.id), height: 400)
                                        .offset(x: 0, y: self.getCardOffset(geometry, id: kitten.id))
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DateView: View {
    var body: some View {
        // Containter to add background and corner radius to
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Friday, 10th January")
                        .font(.title)
                        .bold()
                    Text("Today")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
