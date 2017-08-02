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

@property (nonatomic, strong) NSString *apiResponse;

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
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
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
    bool isButtonRow = indexPath.section == 0 && indexPath.row == 2;
    
    if (isButtonRow) {
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
                          
                          [self dismissViewControllerAnimated:NO completion:nil];
                          
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          NSString *message = [error.userInfo objectForKey:@"NSDebugDescription"];
                          [self showAlert:@"Error" withMessage:message];
                          
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
