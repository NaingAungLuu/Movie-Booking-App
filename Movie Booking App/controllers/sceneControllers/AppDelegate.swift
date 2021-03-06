//
//  AppDelegate.swift
//  Movie Booking App
//
//  Created by Harry Jason on 29/05/2021.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
          if error != nil || user == nil {
            // Show the app's signed-out state.
          } else {
            // Show the app's signed-in state.
          }
        }
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
          return false

    }



}

//<?xml version="1.0" encoding="UTF-8"?>
//<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
//<plist version="1.0">
//<dict>
//    <key>CFBundleDevelopmentRegion</key>
//    <string>$(DEVELOPMENT_LANGUAGE)</string>
//    <key>CFBundleExecutable</key>
//    <string>$(EXECUTABLE_NAME)</string>
//    <key>CFBundleIdentifier</key>
//    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
//    <key>CFBundleInfoDictionaryVersion</key>
//    <string>6.0</string>
//    <key>CFBundleName</key>
//    <string>$(PRODUCT_NAME)</string>
//    <key>CFBundlePackageType</key>
//    <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
//    <key>CFBundleShortVersionString</key>
//    <string>1.0</string>
//    <key>CFBundleURLTypes</key>
//    <array>
//        <dict>
//            <key>CFBundleURLSchemes</key>
//            <array>
//                <string>fb545878473428447</string>
//            </array>
//            <key>CFBundleTypeRole</key>
//            <string>Editor</string>
//        </dict>
//        <dict>
//            <key>CFBundleTypeRole</key>
//            <string>Editor</string>
//            <key>CFBundleURLSchemes</key>
//            <array>
//                <string>com.googleusercontent.apps.832157159209-sa0mscj03j7ffrg1vnb21c77ku91bka5</string>
//            </array>
//        </dict>
//        <dict>
//            <key>CFBundleTypeRole</key>
//            <string>Editor</string>
//            <key>CFBundleURLSchemes</key>
//            <array>
//                <string>fb545878473428447</string>
//            </array>
//        </dict>
//    </array>
//    <key>CFBundleVersion</key>
//    <string>1</string>
//    <key>LSRequiresIPhoneOS</key>
//    <true/>
//    <key>UIAppFonts</key>
//    <array>
//        <string>Poppins-Bold.ttf</string>
//        <string>Poppins-ExtraBold.ttf</string>
//        <string>Poppins-ExtraLight.ttf</string>
//        <string>Poppins-Medium.ttf</string>
//        <string>Poppins-Light.ttf</string>
//    </array>
//    <key>UIApplicationSceneManifest</key>
//    <dict>
//        <key>UIApplicationSupportsMultipleScenes</key>
//        <false/>
//        <key>UISceneConfigurations</key>
//        <dict>
//            <key>UIWindowSceneSessionRoleApplication</key>
//            <array>
//                <dict>
//                    <key>UISceneConfigurationName</key>
//                    <string>Default Configuration</string>
//                    <key>UISceneDelegateClassName</key>
//                    <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
//                    <key>UISceneStoryboardFile</key>
//                    <string>OnBoarding</string>
//                </dict>
//            </array>
//        </dict>
//    </dict>
//    <key>UIApplicationSupportsIndirectInputEvents</key>
//    <true/>
//    <key>UILaunchStoryboardName</key>
//    <string>LaunchScreen</string>
//    <key>UIMainStoryboardFile</key>
//    <string>OnBoarding</string>
//    <key>UIRequiredDeviceCapabilities</key>
//    <array>
//        <string>armv7</string>
//    </array>
//    <key>UISupportedInterfaceOrientations</key>
//    <array>
//        <string>UIInterfaceOrientationPortrait</string>
//        <string>UIInterfaceOrientationLandscapeLeft</string>
//        <string>UIInterfaceOrientationLandscapeRight</string>
//    </array>
//    <key>UISupportedInterfaceOrientations~ipad</key>
//    <array>
//        <string>UIInterfaceOrientationPortrait</string>
//        <string>UIInterfaceOrientationPortraitUpsideDown</string>
//        <string>UIInterfaceOrientationLandscapeLeft</string>
//        <string>UIInterfaceOrientationLandscapeRight</string>
//    </array>
//
//    <key>CFBundleURLTypes</key>
//    <array>
//      <dict>
//      <key>CFBundleURLSchemes</key>
//      <array>
//        <string>fbAPP-ID</string>
//      </array>
//      </dict>
//    </array>
//    <key>FacebookAppID</key>
//    <string>545878473428447</string>
//    <key>FacebookClientToken</key>
//    <string>5826449102e2e766b16e5f42a8f72bf9</string>
//    <key>FacebookDisplayName</key>
//    <string>The Movie Booking App - PADC</string>
//</dict>
//</plist>
