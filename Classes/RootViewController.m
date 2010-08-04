//
//  RootViewController.m
//  AppleStoreBath
//
//  Created by Simon Maddox on 04/08/2010.
//  Copyright Sensible Duck Ltd 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ReservationViewController.h"


@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setTitle:@"Reservations"];

    reservations = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Reservations" ofType:@"plist"]];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [reservations count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[reservations objectAtIndex:section] objectForKey:@"reservations"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterFullStyle];
	
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
	[dateFormatter setLocale:locale];
	[locale release];
	
	NSString *date = [dateFormatter stringFromDate:[[reservations objectAtIndex:section] objectForKey:@"date"]];
	
	[dateFormatter release];
	
	return date;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    	
	[[cell textLabel] setText:[[[[reservations objectAtIndex:indexPath.section] objectForKey:@"reservations"] objectAtIndex:indexPath.row] objectForKey:@"name"]];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReservationViewController *reservationViewController = [[ReservationViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[reservationViewController setArrivalDate:[[reservations objectAtIndex:indexPath.section] objectForKey:@"date"]];
	[reservationViewController setReservation:[[[reservations objectAtIndex:indexPath.section] objectForKey:@"reservations"] objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:reservationViewController animated:YES];
	[reservationViewController release];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[reservations release]; reservations = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

