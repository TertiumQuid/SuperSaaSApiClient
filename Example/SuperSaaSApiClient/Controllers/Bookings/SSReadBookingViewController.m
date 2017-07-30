//
//  SSReadBookingViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadBookingViewController.h"
#import "SSTextFieldTableViewCell.h"

@interface SSReadBookingViewController ()

@property (nonatomic, strong) NSString *bookingId;
@property (nonatomic, strong) NSString *apiResponse;

@end

@implementation SSReadBookingViewController

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
        return 3;
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
        if (indexPath.row == 0) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Limit";
            cell.textField.tag = 0;
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        } else if (indexPath.row == 2) {
            static NSString *cellId = @"ButtonCell";
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                    forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    self.bookingId = textField.text;
}

@end