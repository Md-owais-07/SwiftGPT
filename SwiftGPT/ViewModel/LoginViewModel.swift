//
//  LoginViewModel.swift
//  SwiftGPT
//
//  Created by Owais on 7/31/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var emailTextField: String = "t2@gmail.com"
    @Published var passwordTextField: String = "abcd12"
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    func loginWithFirebase(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    print("Login error with: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Login Success")
                    completion(true)
                }
            }
        }
    }
    
    func fetchUserProfile(uid: String, completion: @escaping (UserModel?) -> Void) {
        isLoading = true
        
        let db = Firestore.firestore()
        let docRef = db.collection("user").document(uid)
        
        docRef.getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            self.isLoading = false
            
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: UserModel.self)
                    completion(user)
                } catch {
                    print("Error decoding user profile: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
}
