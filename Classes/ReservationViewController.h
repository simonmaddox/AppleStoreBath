//
//  ReservationViewController.h
//  AppleStoreBath
//
//  Created by Simon Maddox on 04/08/2010.
//  Copyright 2010 Sensible Duck Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReservationViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
	NSDictionary *reservation;
	NSDate *arrivalDate;
	
	NSArray *offers;
	
	UITableView *mainTable;
	
#pragma mark iPad
	UIPopoverController *popoverController;
	UIToolbar *toolbar;
}

@property (nonatomic, retain) NSDictionary *reservation;
@property (nonatomic, retain) NSDate *arrivalDate;

#pragma mark iPad
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UITableView *mainTable;

- (void) updateReservation:(BOOL) resetChecks;

@end
