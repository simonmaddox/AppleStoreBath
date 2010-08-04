//
//  ReservationViewController.m
//  AppleStoreBath
//
//  Created by Simon Maddox on 04/08/2010.
//  Copyright 2010 Sensible Duck Ltd. All rights reserved.
//

#import "ReservationViewController.h"


@implementation ReservationViewController

@synthesize reservation, arrivalDate;

@synthesize toolbar, mainTable, popoverController;

- (void) viewDidLoad
{
	offers = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Offers" ofType:@"plist"]];
}

- (void) updateReservation:(BOOL) resetChecks
{
	if (resetChecks){
		for (NSInteger i = 0; i < 4; i++){
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
			
			UITableViewCell *cell = [self.mainTable cellForRowAtIndexPath:indexPath];
			
			if (cell.accessoryType != UITableViewCellAccessoryNone){
				[self.mainTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
				[self tableView:self.mainTable didSelectRowAtIndexPath:indexPath];
			}

		}
	}
	
	[self.mainTable reloadData];
	
	if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		return YES;
	}
	
    return UIInterfaceOrientationPortrait;
}

#pragma mark iPad


- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
	barButtonItem.title = @"Reservations";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
		case 0:
			return 5;
			break;
		case 1:
			return 4;
		case 2:
			return [offers count];
		default:
			return 0;
			break;
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
	UITableViewCell *cell = nil;
	
    if (indexPath.section == 0){
		cell = [tableView dequeueReusableCellWithIdentifier:@"Reservation"];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Reservation"] autorelease];
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
				
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setDateStyle:NSDateFormatterFullStyle];
		
		NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
		[dateFormatter setLocale:locale];
		[locale release];
		
		if (indexPath.row == 0){
			cell.textLabel.text = @"Name";
			cell.detailTextLabel.text = [self.reservation objectForKey:@"name"];
		} else if (indexPath.row == 1){
			cell.textLabel.text = @"Room Type";
			cell.detailTextLabel.text = [self.reservation objectForKey:@"type"];
		} else if (indexPath.row == 2){
			cell.textLabel.text = @"Arrival";
			cell.detailTextLabel.text = [dateFormatter stringFromDate:self.arrivalDate];
		} else if (indexPath.row == 3){
			cell.textLabel.text = @"Departure";
			cell.detailTextLabel.text = [dateFormatter stringFromDate:[reservation objectForKey:@"departure"]];
		} else if (indexPath.row == 4){
			cell.textLabel.text = @"Breakfast";
			
			cell.detailTextLabel.text = ([reservation objectForKey:@"breakfast"]) ? @"Yes" :  @"No";
		}
		
		[dateFormatter release];
		
	} else if (indexPath.section == 1){
		cell = [tableView dequeueReusableCellWithIdentifier:@"Checklist"];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Checklist"] autorelease];
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.textLabel.textAlignment = UITextAlignmentCenter;
		}
		
		if (indexPath.row == 0){
			cell.textLabel.text = @"Scanned Passport";
		} else if (indexPath.row == 1){
			cell.textLabel.text = @"Swiped Card";
		} else if (indexPath.row == 2){
			cell.textLabel.text = @"Given Keycard";
		} else if (indexPath.row == 3){
			cell.textLabel.text = @"Breakfast Details";
		}
		
	} else {
		cell = [tableView dequeueReusableCellWithIdentifier:@"Extras"];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Extras"] autorelease];
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		
		cell.textLabel.text = [[offers objectAtIndex:indexPath.row] objectForKey:@"type"];
		cell.detailTextLabel.text = [[offers objectAtIndex:indexPath.row] objectForKey:@"offer"];

	}
        
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.section == 1){
		UITableViewCell *cell = [aTableView cellForRowAtIndexPath:indexPath];
		if (cell.accessoryType == UITableViewCellAccessoryNone){
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.reservation = nil;
	self.arrivalDate = nil;
	
	self.mainTable = nil;
	self.toolbar = nil;
	
	[offers release]; offers = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

