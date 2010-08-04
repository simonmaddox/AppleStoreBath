//
//  AppleStoreBathAppDelegate.h
//  AppleStoreBath
//
//  Created by Simon Maddox on 04/08/2010.
//  Copyright Sensible Duck Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppleStoreBathAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

