//
//  SSReadBookingsViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadBookingsViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

@interface SSReadBookingsViewController ()

@property (nonatomic, strong) NSString *scheduleId;
@property (nonatomic, strong) NSNumber *limit;

@end

@implementation SSReadBookingsViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSInteger rows = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row < rows - 1) {
            NSString *text = @"";
            if (indexPath.row == 0) {
                text = @"Schedule ID";
            } else if (indexPath.row == 1) {
                text = @"Limit";
            }
            
            SSTextFieldTableViewCell *cell = [self getTextFieldCell:tableView
                                                       forIndexPath:indexPath
                                                           withText:text
                                                            withTag:indexPath.row];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
            
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

#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.scheduleId = textField.text;
    } else if (textField.tag == 1) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        self.limit = [formatter numberFromString:textField.text];
    }
}

@end
