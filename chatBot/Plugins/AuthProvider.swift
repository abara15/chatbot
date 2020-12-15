//
//  AuthProvider.swift
//  chatBot
//
//  Created by Anthony Barakat on 6/29/18.
//  Copyright © 2018 Anthony Barakat. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias LoginHandler = (_ msg: String?) -> Void; // We don't return anything.

struct LoginErrorCode { // To handle the login errors (see errCode).
    // Below are the messages to display to the user depending on the error.
    static let INVALID_EMAIL = "Invalid email address. Please enter a valid email address."
    static let WRONG_PASSWORD = "Invalid password. Please enter a valid password."
    static let USER_NOT_FOUND = "User not found. Please enter valid credentials or register."
    static let EMAIL_IN_USE = "Email address is already in use. Please enter a valid email address."
    static let WEAK_PASSWORD = "Weak password. Please enter a stronger password."
    static let USER_DISABLED = "User disabled. Please try again later."
    static let MISSING_PHONE_NO = "Missing phone number. Please enter a valid phone number."
    static let NETWORK_ERROR = "Network error. Please try again later."
    static let SESSION_EXPIRED = "Session expired. Please try again later."
    static let QUOTA_EXCEEDED = "Quota exceeded. Please try again later."
    static let MISSING_EMAIL = "Missing email address. Please enter a valid email address."
    static let PROBLEM_CONNECTING = "Problem connecting to the database. Please try again later."
}

class AuthProvider {
    
    private static let _instance = AuthProvider();
    
    static var Instance: AuthProvider {
        return _instance;
    }
    
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            if error != nil { // Occurs when we do not have a value for our LoginHandler.
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler); // Handle the errors as NSError while referring to loginHandler.
            } else {
                loginHandler?(nil);
            }
        });
    } //login function
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?) { // Possible errors include wrong password, email address already in use, password too weak etc.
        
        if let errCode = AuthErrorCode(rawValue: err.code) { // Examples of these error codes include NetworkError, UserNotFound, TooManyRequests etc. (from Firebase documentation).
            
            switch errCode {
            // Below is a casewhere structure of potential errors that could result from a user logging in.
            // Go back to the Firebase documentation for AuthErrorCode (SWIFT) and add in all the variations.
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
            case .userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_IN_USE);
                break;
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
            case .userDisabled:
                loginHandler?(LoginErrorCode.USER_DISABLED);
                break;
            case .missingPhoneNumber:
                loginHandler?(LoginErrorCode.MISSING_PHONE_NO);
                break;
            case .networkError:
                loginHandler?(LoginErrorCode.NETWORK_ERROR);
                break;
            case .sessionExpired:
                loginHandler?(LoginErrorCode.SESSION_EXPIRED);
                break;
            case .quotaExceeded:
                loginHandler?(LoginErrorCode.QUOTA_EXCEEDED);
                break;
            case .missingEmail:
                loginHandler?(LoginErrorCode.MISSING_EMAIL);
                break;
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
                
            }
            
        }
    }
    
} //class
