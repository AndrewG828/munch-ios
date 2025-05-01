//
//  Camera.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//

//import SwiftUI
//import PhotosUI
//
//struct ScanPage: View {
//    @State private var selectedImage: UIImage? = nil
//        @State private var showImagePicker = false
//
//        var body: some View {
//            VStack(spacing: 24) {
//                if let image = selectedImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 300)
//                        .cornerRadius(12)
//
//                    Button("Send to Backend") {
//                        uploadImageToBackend(image)
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(8)
//                } else {
//                    Text("Tap the button below to scan a food item.")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//
//                Spacer()
//
//                Button {
//                    showImagePicker = true
//                } label: {
//                    Label("Open Camera", systemImage: "camera.fill")
//                        .padding()
//                        .background(Color.yellow.opacity(0.8))
//                        .cornerRadius(12)
//                        .foregroundColor(.black)
//                }
//            }
//            .padding()
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: $selectedImage)
//            }
//        }
//
//        func uploadImageToBackend(_ image: UIImage) {
//            guard let imageData = image.jpegData(compressionQuality: 0.8),
//                  let url = URL(string: "https://your-backend.com/upload") else { return }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
//            request.httpBody = imageData
//
//            URLSession.shared.dataTask(with: request) { _, response, error in
//                if let error = error {
//                    print("Upload failed:", error.localizedDescription)
//                } else {
//                    print("Upload succeeded.")
//                }
//            }.resume()
//        }
//}
//
//#Preview {
//    ScanPage()
//}

import SwiftUI
import PhotosUI

struct ScanPage: View {
    @State private var selectedImage: UIImage? = nil
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 24) {
            if let image = selectedImage {
                // Display captured image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)

                // Action buttons
                HStack(spacing: 16) {
                    Button("Retake") {
                        selectedImage = nil
                        openCamera()
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                    Button("Send to Backend") {
                        uploadImageToBackend(image)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            } else {
                // Show loading placeholder
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            }
        }
        .padding()
        .onAppear {
            if selectedImage == nil {
                openCamera()
            }
        }
    }

    func uploadImageToBackend(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8),
              let url = URL(string: "https://your-backend.com/upload") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.httpBody = imageData

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("Upload failed:", error.localizedDescription)
            } else {
                print("Upload succeeded.")
            }
        }.resume()
    }

    func openCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = CameraDelegate(onImagePicked: { image in
            self.selectedImage = image
        })

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            var topController = rootViewController
            while let presented = topController.presentedViewController {
                topController = presented
            }
            topController.present(picker, animated: true)
        }
    }
}

// Camera delegate for handling the native camera interface
class CameraDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let onImagePicked: (UIImage) -> Void

    init(onImagePicked: @escaping (UIImage) -> Void) {
        self.onImagePicked = onImagePicked
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.onImagePicked(image)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

#Preview {
    ScanPage()
}
