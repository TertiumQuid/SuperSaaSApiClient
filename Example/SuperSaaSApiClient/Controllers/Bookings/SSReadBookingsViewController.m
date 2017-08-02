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
@property (nonatomic, strong) NSString *apiResponse;

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
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            if (indexPath.row == 0) {
                cell.textField.placeholder = @"Schedule ID";
                cell.textField.tag = 0;
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                return cell;
            } else if (indexPath.row == 1) {
                cell.textField.placeholder = @"Limit";
                cell.textField.tag = 1;
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                return cell;
            }
            
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
