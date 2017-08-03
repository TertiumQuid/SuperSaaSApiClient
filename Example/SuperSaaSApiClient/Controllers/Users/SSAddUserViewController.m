//
//  SSAddUserViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSAddUserViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

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

@end

@implementation SSAddUserViewController

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
            NSString *text = @"";
            if (indexPath.row == 0) {
                text = @"Name";
            } else if (indexPath.row == 1) {
                text = @"Email";
            } else if (indexPath.row == 2) {
                text = @"Password";
            } else if (indexPath.row == 3) {
                text = @"Full Name";
            } else if (indexPath.row == 4) {
                text = @"Address";
            } else if (indexPath.row == 5) {
                text = @"Mobile";
            } else if (indexPath.row == 6) {
                text = @"Phone";
            } else if (indexPath.row == 7) {
                text = @"Country";
            } else if (indexPath.row == 8) {
                text = @"Field1";
            } else if (indexPath.row == 9) {
                text = @"Field2";
            } else if (indexPath.row == 10) {
                text = @"Super Field";
            } else if (indexPath.row == 11) {
                text = @"Credit";
            } else if (indexPath.row == 12) {
                text = @"Role";
            } else if (indexPath.row == 13) {
                text = @"User ID";
            }
            
            return [self getTextFieldCell:tableView
                             forIndexPath:indexPath
                                 withText:text
                                  withTag:indexPath.row];
            
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

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isButtonRow:tableView forIndexPath:indexPath]) {
        [self showApiLoading];
        [SSApiClient createUser:self.name
                          email:self.email
                       password:self.password
                       fullName:self.fullName
                        address:self.address
                         mobile:self.mobile
                          phone:self.phone
                        country:self.country
                         field1:self.field1
                         field2:self.field2
                     superField:self.superField
                         credit:self.credit
                           role:self.role
                         userId:self.userId
                        success:^(NSURLSessionDataTask *task, id responseObject) {
                            [self showApiResponse:responseObject];
                        }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                          [self showApiError:error];
                      }];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
