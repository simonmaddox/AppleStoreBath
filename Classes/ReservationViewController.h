//
//  ReservationViewController.h
//  AppleStoreBath
//
//  Created by Simon Maddox on 04/08/2010.
//  Copyright 2010 Sensible Duck Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReservationViewController : UITableViewController {
	NSDictionary *reservation;
	NSDate *arrivalDate;
	
	NSArray *offers;
}

@property (nonatomic, retain) NSDictionary *reservation;
@property (nonatomic, retain) NSDate *arrivalDate;

@end
