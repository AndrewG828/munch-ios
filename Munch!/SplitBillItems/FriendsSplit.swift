//
//  FriendsSplit.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//
import SwiftUI

struct AssignFriendsScreen: View {
    let foodName: String
    var onAssign: ([String]) -> Void

    @Environment(\.dismiss) var dismiss
    @State private var selectedFriends: Set<String> = []

    let friends = ["Jimmy Chen", "Jason Guo", "Fanhao Yu", "Jiwon Jeong"]

    var body: some View {
            VStack(spacing: 20) {
                Text("Assign \(foodName)")
                    .font(.title.bold())
                    .padding(.top)

                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(friends, id: \.self) { friend in
                            HStack {
                                Text(friend)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)

                                Spacer()

                                Image(systemName: selectedFriends.contains(friend) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(selectedFriends.contains(friend) ? .green : .gray)
                                    .imageScale(.large)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            .onTapGesture {
                                if selectedFriends.contains(friend) {
                                    selectedFriends.remove(friend)
                                } else {
                                    selectedFriends.insert(friend)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()

                Button {
                    onAssign(Array(selectedFriends))
                    dismiss()
                } label: {
                    Text("Assign Friends")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedFriends.isEmpty ? Color.gray.opacity(0.4) : Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .padding(.horizontal)
                }
                .disabled(selectedFriends.isEmpty)

                Spacer(minLength: 20)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
}

