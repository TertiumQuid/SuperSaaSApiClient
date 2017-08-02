//
//  SSFormViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSFormViewController.h"
#import "SSTextFieldTableViewCell.h"

@interface SSFormViewController ()

@end

@implementation SSFormViewController

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Enter API Input";
    } else {
        return @"API Response";
    }
}

#pragma mark - Alerts
    
- (void) showAlert:(NSString *)title withMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (UITableViewCell *) getButtonCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ButtonCell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                            forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"Submit";
    return cell;
}

- (SSTextFieldTableViewCell *) getResponseCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath withText:(NSString *)text {
    static NSString *cellId = @"ResponseCell";
    [self.tableView registerClass:[SSTextFieldTableViewCell class] forCellReuseIdentifier:cellId];
    SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                     forIndexPath:indexPath];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.textLabel.text = text;
    return cell;
}

@end
