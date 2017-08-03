//
//  SSSettingsViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSSettingsViewController.h"
#import "SSLabelTableViewCell.h"
#import "SSApiClient.h"

NSString * const kStoredAccountKey = @"SaaSAccountName";
NSString * const kStoredUserKey = @"SaaSUsername";
NSString * const kStoredChecksumKey = @"SaaSChecksumToken";

@interface SSSettingsViewController ()

@end

@implementation SSSettingsViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Credentials";
    } else {
        return @"";
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (indexPath.section == 0) {
        static NSString *cellId = @"LabelCell";
        [self.tableView registerClass:[SSLabelTableViewCell class] forCellReuseIdentifier:cellId];
        SSLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                     forIndexPath:indexPath];
        
        NSString *text = @"";
        if (indexPath.row == 0) {
            text = [NSString stringWithFormat:@"Account ID: %@", [defaults stringForKey:kStoredAccountKey]];
        } else if (indexPath.row == 1) {
            text = [NSString stringWithFormat:@"User ID: %@", [defaults stringForKey:kStoredUserKey]];
        } else if (indexPath.row == 2) {
            text = [NSString stringWithFormat:@"Checksum: %@", [defaults stringForKey:kStoredChecksumKey]];
        }
        cell.textLabel.text = text;
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    } else {
        static NSString *cellId = @"ButtonCell";
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"Logout";
        return cell;
    }
    return nil;
}
    
#pragma mark - Table view delegate
    
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        [SSApiClient logout];
        [self performSegueWithIdentifier:@"ShowLogoutSegue" sender:self];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
@end
