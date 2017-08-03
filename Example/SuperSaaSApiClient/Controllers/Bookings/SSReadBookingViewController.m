//
//  SSReadBookingViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadBookingViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

@interface SSReadBookingViewController ()

@property (nonatomic, strong) NSString *bookingId;

@end

@implementation SSReadBookingViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [self getTextFieldCell:tableView
                             forIndexPath:indexPath
                                 withText:@"Booking ID"
                                  withTag:0];
        } else {
            return [self getButtonCell:tableView forIndexPath:indexPath];
        }
    } if (indexPath.section == 1) {
        return [self getResponseCell:tableView
                        forIndexPath:indexPath
                            withText:self.apiResponse];
    }
    return nil;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    bool isButtonRow = indexPath.section == 0 && indexPath.row == 1;
    
    if (isButtonRow) {
        [SSApiClient readBooking:self.bookingId
                         success:^(NSURLSessionDataTask *task, id responseObject) {
                             self.apiResponse = [NSString stringWithFormat:@"%@", responseObject];
                             [self.tableView reloadData];
                             
                         } failure:^(NSURLSessionDataTask *task, NSError *error) {
                             [self showApiError:error];
                         }];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.bookingId = textField.text;
}

@end
