//
//  SSAddBookingViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSAddBookingViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

@interface SSAddBookingViewController ()

@property (nonatomic, strong) NSString *scheduleId;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *slotId;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *field1;
@property (nonatomic, strong) NSString *field2;
@property (nonatomic, strong) NSString *field1r;;
@property (nonatomic, strong) NSString *field2r;
@property (nonatomic, strong) NSString *superField;

@property (nonatomic, strong) NSString *apiResponse;

@end

@implementation SSAddBookingViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
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
            cell.textField.tag = indexPath.row;
            
            if (indexPath.row == 0) {
                cell.textField.placeholder = @"Schedule ID";
            } else if (indexPath.row == 1) {
                cell.textField.placeholder = @"User";
            } else if (indexPath.row == 2) {
                cell.textField.placeholder = @"Slot ID";
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
                cell.textField.placeholder = @"Email";
            } else if (indexPath.row == 9) {
                cell.textField.placeholder = @"Field1";
            } else if (indexPath.row == 10) {
                cell.textField.placeholder = @"Field2";
            } else if (indexPath.row == 11) {
                cell.textField.placeholder = @"Field1r";
            } else if (indexPath.row == 12) {
                cell.textField.placeholder = @"Field2r";
            } else if (indexPath.row == 13) {
                cell.textField.placeholder = @"Super Field";
            }
            
            return cell;
            
        } else {
            return [self getButtonCell:tableView forIndexPath:indexPath];
        }
        
    } else if (indexPath.section == 1) {
        return [self getResponseCell:tableView
                        forIndexPath:indexPath
                            withText:self.apiResponse];
    }
    return nil;
}

#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField.tag == 0) {
//        self.name = textField.text;
//    } else if (textField.tag == 1) {
//        self.email = textField.text;
//    } else if (textField.tag == 2) {
//        self.password = textField.text;
//    } else if (textField.tag == 3) {
//        self.fullName = textField.text;
//    } else if (textField.tag == 4) {
//        self.address = textField.text;
//    } else if (textField.tag == 5) {
//        self.mobile = textField.text;
//    } else if (textField.tag == 6) {
//        self.phone = textField.text;
//    } else if (textField.tag == 7) {
//        self.country = textField.text;
//    } else if (textField.tag == 8) {
//        self.field1 = textField.text;
//    } else if (textField.tag == 9) {
//        self.field2 = textField.text;
//    } else if (textField.tag == 10) {
//        self.superField = textField.text;
//    } else if (textField.tag == 11) {
//        self.credit = textField.text;
//    } else if (textField.tag == 12) {
//        self.role = textField.text;
//    } else if (textField.tag == 13) {
//        self.userId = textField.text;
//    }
}

@end
