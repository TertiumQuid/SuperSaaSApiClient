//
//  SSReadRecentChangesViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 30/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadRecentChangesViewController.h"
#import "SSTextFieldTableViewCell.h"

@interface SSReadRecentChangesViewController ()

@property (nonatomic, strong) NSString *scheduleId;
@property (nonatomic, strong) NSString *slot;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *apiResponse;

@end

@implementation SSReadRecentChangesViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
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
                cell.textField.delegate = self;
                cell.textField.placeholder = @"Schedule ID";
                cell.textField.tag = 0;
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                [cell setLayoutMargins:UIEdgeInsetsZero];
                return cell;
            } else if (indexPath.row == 1) {
                cell.textField.delegate = self;
                cell.textField.placeholder = @"Slot";
                cell.textField.tag = 1;
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                [cell setLayoutMargins:UIEdgeInsetsZero];
                return cell;
            } else if (indexPath.row == 2) {
                cell.textField.delegate = self;
                cell.textField.placeholder = @"From";
                cell.textField.tag = 1;
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                [cell setLayoutMargins:UIEdgeInsetsZero];
                return cell;
            } else if (indexPath.row == 3) {
                static NSString *cellId = @"ButtonCell";
                [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                        forIndexPath:indexPath];
                cell.textLabel.text = @"Submit";
                return cell;
            }
            
        } else {
            static NSString *cellId = @"ButtonCell";
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                    forIndexPath:indexPath];
            cell.textLabel.text = @"Submit";
            return cell;
        }
        
    } if (indexPath.section == 1) {
        static NSString *cellId = @"ResponseCell";
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                forIndexPath:indexPath];
        cell.textLabel.text = self.apiResponse;
        return cell;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Enter API Input";
    } else {
        return @"API Response";
    }
}


#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.scheduleId = textField.text;
    } else if (textField.tag == 1) {
        self.slot = textField.text;
    } else if (textField.tag == 2) {
        self.from = textField.text;
    }
}

@end
