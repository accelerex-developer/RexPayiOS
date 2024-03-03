//
//  RexpaySDKTests.swift
//  RexpaySDKTests
//
//  Created by Abdullah on 21/01/2024.
//

import XCTest
@testable import RexpaySDK
import SwiftUI

final class RexpaySDKTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}



//struct SwitUIClientView: View {
//
//    @State var isRexpaySDKPresented = false
//
//    var body: some View {
//        VStack {
//            Text("Swifui Project")
//                .padding(.bottom, 20)
//            Button("Lauch RexpaySDK") {
//                isRexpaySDKPresented = true
//            }
//            .fullScreenCover(isPresented: $isRexpaySDKPresented) {
//                makeRexpaySDK()
//            }
//        }
//        .padding()
//    }
//
//    func makeRexpaySDK () -> some View {
//        let config = RexpaySDKConfig()
//        config.email = "abc@swiftui.com"
//        config.amount = 500
//
//        let rexpaySDK = RexpaySDK(config: config)
//        return rexpaySDK.launch(hostView: self)
//            .edgesIgnoringSafeArea(.all)
//    }
//}
