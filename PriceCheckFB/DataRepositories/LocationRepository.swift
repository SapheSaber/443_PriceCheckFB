// Created by Prof. H in 2022
// Part of the PriceCheckFB project
// Using Swift 5.0
// Qapla'


import Combine
import Firebase
import Foundation
import FirebaseFirestore
// import Firebase modules here


class LocationRepository: ObservableObject {
  // Set up properties here
  private let db = Firestore.firestore()
  @Published var locations: [Location] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    get()
  }

  func get() {
    // Complete this function
    db.collection("location_scans").addSnapshotListener { querySnapshot, error in
      if let error = error {
        print("Error getting books: \(error.localizedDescription)")
        return
      }

      self.locations = querySnapshot?.documents.compactMap { document in
        try? document.data(as: Location.self)
      } ?? []
    }
  }
}
