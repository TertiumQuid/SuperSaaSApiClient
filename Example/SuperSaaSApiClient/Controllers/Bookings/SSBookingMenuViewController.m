//
//  SSBookingMenuViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSBookingMenuViewController.h"

@interface SSBookingMenuViewController ()

@end

@implementation SSBookingMenuViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
    
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select an API Method";
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"MenuCell";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                            forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Read Free";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Read Bookings";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"Read Booking";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"Add Booking";
    }
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ShowReadFreeSegue" sender:self];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"ShowReadBookingsSegue" sender:self];
    } else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"ShowReadBookingSegue" sender:self];
    } else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"ShowReadAddBookingSegue" sender:self];
    }
}

@end
