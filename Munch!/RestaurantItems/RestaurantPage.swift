//
//  RestaurantPage.swift
//  Munch!
//
//  Created by Andrew Gao on 5/2/25.
//
import SwiftUI
import MapKit

struct RestaurantPage: View {
    let restaurant: Restaurant
    let user: User

    @Environment(\.dismiss) var dismiss

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.44, longitude: -76.50), // fallback
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var restaurantCoordinate: CLLocationCoordinate2D?
    @State private var annotations: [MapPin] = []
    @State private var hasSetRegion = false
    @State private var userHasMovedMap = false

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                ZStack(alignment: .topLeading) {
                    Map(
                        coordinateRegion: $region,
                        interactionModes: [.all],
                        annotationItems: annotations
                    ) { pin in
                        MapAnnotation(coordinate: pin.coordinate) {
                            Button {
                                openInMaps(coordinate: pin.coordinate, name: restaurant.name)
                            } label: {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    .shadow(radius: 2)
                            }
                        }
                    }
                    .frame(height: 300)
                    .onAppear {
                        geocodeAddress(restaurant.address)
                    }
                    .simultaneousGesture(DragGesture().onChanged { _ in
                        userHasMovedMap = true
                    })

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding(10)
                            .shadow(radius: 2)
                    }
                    .padding(.top, 25)
                    .padding(.leading, 16)

                    if userHasMovedMap {
                        Button {
                            if let coord = restaurantCoordinate {
                                withAnimation {
                                    region.center = coord
                                    userHasMovedMap = false
                                }
                            }
                        } label: {
                            Image(systemName: "location.fill")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        .padding(.top, 25)
                        .padding(.trailing, 16)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    VStack {
                        Spacer()
                        HStack {
                            Text(restaurant.name)
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.black)
                                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 1, y: 2)
                                .padding(.leading, 16)
                                .padding(.bottom, 25)
                            Spacer()
                        }
                        .padding(.bottom, 20)
                    }
                }

                VStack(spacing: 20) {
                    ForEach(restaurant.menu, id: \.id) { food in
                        NavigationLink(destination: ReviewPage(food: food, user: user)){
                            FoodCell(food: food)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }

    func geocodeAddress(_ address: String) {
        guard !hasSetRegion else { return }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, _ in
            if let coordinate = placemarks?.first?.location?.coordinate {
                restaurantCoordinate = coordinate
                region.center = coordinate
                hasSetRegion = true
                annotations = [MapPin(coordinate: coordinate)]
            }
        }
    }


    func openInMaps(coordinate: CLLocationCoordinate2D, name: String) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: nil)
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}


