//
//  UIView_X_Y_Height_widthUITests.m
//  UIView-X-Y-Height-widthUITests
//
//  Created by 洪绵卫 on 2017/8/23.
//  Copyright © 2017年 洪绵卫. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UIView_X_Y_Height_widthUITests : XCTestCase

@end

@implementation UIView_X_Y_Height_widthUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
