//
//  RootViewController.h
//  AppleStoreBath
//
//  Created by Simon Maddox on 04/08/2010.
//  Copyright Sensible Duck Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReservationViewController;

@interface RootViewController : UITableViewController {
	NSArray *reservations;
	
	ReservationViewController *reservationViewController;
	
	BOOL firstLoad;
	BOOL autoSelect;
}

@property (nonatomic, retain) IBOutlet ReservationViewController *reservationViewController;

- (void) selectFirst;

@end
