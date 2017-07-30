//
//  SSReadAgendaViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 30/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadAgendaViewController.h"
#import "SSTextFieldTableViewCell.h"

@interface SSReadAgendaViewController ()

@property (nonatomic, strong) NSString *scheduleId;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *apiResponse;

@end

@implementation SSReadAgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
}

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Enter API Input";
    } else {
        return @"API Response";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSInteger rows = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row < rows - 1) {
        } else {
            static NSString *cellId = @"ButtonCell";
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                    forIndexPath:indexPath];
            cell.textLabel.text = @"Submit";
            return cell;
            
        }
        
        
        if (indexPath.row == 0) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Limit";
            cell.textField.tag = 0;
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Offset";
            cell.textField.tag = 1;
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        } else if (indexPath.row == 2) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Offset";
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

#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.scheduleId = textField.text;
    } else if (textField.tag == 1) {
        self.user = textField.text;
    } else if (textField.tag == 2) {
        self.from = textField.text;
    }
}

@end