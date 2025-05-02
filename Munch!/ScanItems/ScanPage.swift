//
//  Camera.swift
//  Munch!
//
//  Created by Andrew Gao on 5/1/25.
//

import SwiftUI
import PhotosUI

struct ScanPage: View {
    @State private var showCamera = false
    @State private var navigateToSplit = false
    
    @StateObject var receiptViewModel = ReceiptViewModel()

    var body: some View {
        NavigationStack {
            ZStack{
                Color.clear
                    .onAppear {
                        showCamera = true
                    }
                    .navigationDestination(isPresented: $navigateToSplit) {
                        SplitBillScreen(items: receiptViewModel.splitFoods)
                    }
                    .fullScreenCover(isPresented: $showCamera) {
                        CameraView { image in
                            receiptViewModel.receiptImage = image
                            receiptViewModel.scrapeReceipt()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) {
                                self.navigateToSplit = true
                            }
                        }
                    }
                
                if receiptViewModel.isLoading {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()

                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.5)
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))

                            Text("Analyzing receipt...")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .padding(32)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(radius: 10)
                        )
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: receiptViewModel.isLoading)
                    }
                }
            }
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    var onImagePicked: (UIImage) -> Void

    func makeCoordinator() -> CameraDelegate {
        return CameraDelegate(onImagePicked: onImagePicked)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

class CameraDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let onImagePicked: (UIImage) -> Void

    init(onImagePicked: @escaping (UIImage) -> Void) {
        self.onImagePicked = onImagePicked
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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

