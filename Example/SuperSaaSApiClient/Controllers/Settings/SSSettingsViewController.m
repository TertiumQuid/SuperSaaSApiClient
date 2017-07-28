//
//  SSSettingsViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSSettingsViewController.h"
#import "SSLoginViewController.h"
#import "SSApiClient.h"

NSString * const kStoredAccountKey = @"SaaSAccountName";
NSString * const kStoredUserKey = @"SaaSUsername";

@interface SSSettingsViewController ()

@end

@implementation SSSettingsViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Account Name";
    } else if (section == 1) {
        return @"User Name";
    } else {
        return @"";
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (indexPath.section == 0) {
        static NSString *cellId = @"LabelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                         forIndexPath:indexPath];
        cell.textLabel.text = [defaults stringForKey:kStoredAccountKey];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *cellId = @"LabelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                forIndexPath:indexPath];
        cell.textLabel.text = [defaults stringForKey:kStoredUserKey];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    } else if (indexPath.section == 2) {
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
