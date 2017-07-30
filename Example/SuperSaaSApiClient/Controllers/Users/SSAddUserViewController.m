//
//  SSAddUserViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSAddUserViewController.h"
#import "SSTextFieldTableViewCell.h"

@interface SSAddUserViewController ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *field1;
@property (nonatomic, strong) NSString *field2;
@property (nonatomic, strong) NSString *superField;
@property (nonatomic, strong) NSString *credit;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *apiResponse;

@end

@implementation SSAddUserViewController

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
        return 14;
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
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.tag = indexPath.row;
            
            if (indexPath.row == 0) {
                cell.textField.placeholder = @"Name";
            } else if (indexPath.row == 1) {
                cell.textField.placeholder = @"Email";
            } else if (indexPath.row == 2) {
                cell.textField.placeholder = @"Password";
            } else if (indexPath.row == 3) {
                cell.textField.placeholder = @"Full Name";
            } else if (indexPath.row == 4) {
                cell.textField.placeholder = @"Address";
            } else if (indexPath.row == 5) {
                cell.textField.placeholder = @"Mobile";
            } else if (indexPath.row == 6) {
                cell.textField.placeholder = @"Phone";
            } else if (indexPath.row == 7) {
                cell.textField.placeholder = @"Country";
            } else if (indexPath.row == 8) {
                cell.textField.placeholder = @"Field1";
            } else if (indexPath.row == 9) {
                cell.textField.placeholder = @"Field2";
            } else if (indexPath.row == 10) {
                cell.textField.placeholder = @"Super Field";
            } else if (indexPath.row == 11) {
                cell.textField.placeholder = @"Credit";
            } else if (indexPath.row == 12) {
                cell.textField.placeholder = @"Role";
            } else if (indexPath.row == 13) {
                cell.textField.placeholder = @"User ID";
            }
            
            return cell;
            
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
        [cell setLayoutMargins:UIEdgeInsetsZero];
        cell.textLabel.text = self.apiResponse;
        return cell;
    }
    return nil;
}

#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.name = textField.text;
    } else if (textField.tag == 1) {
        self.email = textField.text;
    } else if (textField.tag == 2) {
        self.password = textField.text;
    } else if (textField.tag == 3) {
        self.fullName = textField.text;
    } else if (textField.tag == 4) {
        self.address = textField.text;
    } else if (textField.tag == 5) {
        self.mobile = textField.text;
    } else if (textField.tag == 6) {
        self.phone = textField.text;
    } else if (textField.tag == 7) {
        self.country = textField.text;
    } else if (textField.tag == 8) {
        self.field1 = textField.text;
    } else if (textField.tag == 9) {
        self.field2 = textField.text;
    } else if (textField.tag == 10) {
        self.superField = textField.text;
    } else if (textField.tag == 11) {
        self.credit = textField.text;
    } else if (textField.tag == 12) {
        self.role = textField.text;
    } else if (textField.tag == 13) {
        self.userId = textField.text;
    }
}

@end
