//
//  SSFormViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSFormViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSLabelTableViewCell.h"

@interface SSFormViewController ()

@end

@implementation SSFormViewController

- (NSNumber *) getNumber:(NSString *)text {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [formatter numberFromString:text];
}

- (NSDate *) getDate:(NSString *)text {
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"YYYY-MM-DD HH:MM:SS"];
    return [dateformat dateFromString:text];
}

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

- (void) showApiError:(NSError *)error {
    NSString *message = [error.userInfo objectForKey:@"NSDebugDescription"];
    [self showAlert:@"Error" withMessage:message];
    
    self.apiResponse = @"";
    [self.tableView reloadData];
}

#pragma mark - Table Cells

- (UITableViewCell *) getButtonCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ButtonCell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                            forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"Submit";
    return cell;
}

- (SSTextFieldTableViewCell *) getTextFieldCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath withText:(NSString *)text withTag:(NSInteger)tag {
    static NSString *cellId = @"TextFieldCell";
    SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                     forIndexPath:indexPath];
    cell.textField.placeholder = text;
    cell.textField.tag = tag;
    return cell;
    
}

- (SSLabelTableViewCell *) getResponseCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath withText:(NSString *)text {
    static NSString *cellId = @"ResponseCell";
    [self.tableView registerClass:[SSLabelTableViewCell class] forCellReuseIdentifier:cellId];
    SSLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                     forIndexPath:indexPath];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.textLabel.text = text;
    return cell;
}

@end
