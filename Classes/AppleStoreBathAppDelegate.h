//
//  AppleStoreBathAppDelegate.h
//  AppleStoreBath
//
//  Created by Simon Maddox on 04/08/2010.
//  Copyright Sensible Duck Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class ReservationViewController;

@interface AppleStoreBathAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	
#pragma mark iPhone
    UINavigationController *navigationController;
	
#pragma mark iPad
	UISplitViewController *splitViewController;
    
    RootViewController *rootViewController;
    ReservationViewController *reservationViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

#pragma mark iPhone
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

#pragma mark iPad
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet ReservationViewController *reservationViewController;

@end

