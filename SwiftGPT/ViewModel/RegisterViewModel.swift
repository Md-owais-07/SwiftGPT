//
//  RegisterViewModel.swift
//  SwiftGPT
//
//  Created by Owais on 7/31/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var nameTextField: String = "Neck John"
    @Published var emailTextField: String = "t3@gmail.com"
    @Published var passwordTextField: String = "abcd12"
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func createUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error as NSError? {
                    if let errorCode = AuthErrorCode(rawValue: error.code) {
                        switch errorCode {
                        case .emailAlreadyInUse:
                            self.errorMessage = "This email is already in use."
                        case .invalidEmail:
                            self.errorMessage = "Please enter a valid email address."
                        case .weakPassword:
                            self.errorMessage = "Password must be at least 6 characters."
                        default :
                            self.errorMessage = error.localizedDescription
                        }
                    }
                    completion(false)
                } else {
                    self.errorMessage = nil
                    completion(true)
                    print("Register Successful...")
                }
            }
        }
    }
    
    func createUserProfile(uid: String, name: String, email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("user").document(uid).setData([
            "name": name,
            "email": email
        ]) { error in
            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
