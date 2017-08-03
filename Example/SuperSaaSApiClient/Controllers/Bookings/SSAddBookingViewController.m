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
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSDate *start;
@property (nonatomic, strong) NSDate *finish;
@property (nonatomic, strong) NSString *slotId;
@property (nonatomic, strong) NSString *resourceId;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *field1;
@property (nonatomic, strong) NSString *field2;
@property (nonatomic, strong) NSString *field1r;
@property (nonatomic, strong) NSString *field2r;
@property (nonatomic, strong) NSString *superField;

@end

@implementation SSAddBookingViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 18;
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
            
            NSString *text = @"";
            if (indexPath.row == 0) {
                text = @"Schedule ID";
            } else if (indexPath.row == 1) {
                text = @"User ID";
            } else if (indexPath.row == 2) {
                text = @"Start";
            } else if (indexPath.row == 3) {
                text = @"Finish";
            } else if (indexPath.row == 4) {
                text = @"Slot ID";
            } else if (indexPath.row == 5) {
                text = @"Resource ID";
            } else if (indexPath.row == 6) {
                text = @"Full Name";
            } else if (indexPath.row == 7) {
                text = @"Address";
            } else if (indexPath.row == 8) {
                text = @"Mobile";
            } else if (indexPath.row == 9) {
                text = @"Phone";
            } else if (indexPath.row == 10) {
                text = @"Country";
            } else if (indexPath.row == 11) {
                text = @"Email";
            } else if (indexPath.row == 12) {
                text = @"Field1";
            } else if (indexPath.row == 13) {
                text = @"Field2";
            } else if (indexPath.row == 14) {
                text = @"Field1r";
            } else if (indexPath.row == 15) {
                text = @"Field2r";
            } else if (indexPath.row == 16) {
                text = @"Super Field";
            }
            cell.textField.placeholder = text;
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
    if ([self isButtonRow:tableView forIndexPath:indexPath]) {
        [self showApiLoading];
        [SSApiClient createBooking:self.scheduleId
                            userId:self.userId 
                             start:self.start
                            finish:self.finish
                            slotId:self.slotId
                        resourceId:self.resourceId
                          fullName:self.fullName
                           address:self.address
                            mobile:self.mobile
                             phone:self.phone
                           country:self.country
                             email:self.email
                            field1:self.field1
                            field2:self.field2
                           field1r:self.field1r
                           field2r:self.field2r
                        superField:self.superField
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
        self.scheduleId = textField.text;
    } else if (textField.tag == 1) {
        self.userId = textField.text;
    } else if (textField.tag == 2) {
        self.start = [self getDate:textField.text];
    } else if (textField.tag == 3) {
        self.finish = [self getDate:textField.text];
    } else if (textField.tag == 4) {
        self.slotId = textField.text;
    } else if (textField.tag == 5) {
        self.resourceId = textField.text;
    } else if (textField.tag == 6) {
        self.fullName = textField.text;
    } else if (textField.tag == 7) {
        self.address = textField.text;
    } else if (textField.tag == 8) {
        self.mobile = textField.text;
    } else if (textField.tag == 9) {
        self.phone = textField.text;
    } else if (textField.tag == 10) {
        self.country = textField.text;
    } else if (textField.tag == 11) {
        self.email = textField.text;
    } else if (textField.tag == 12) {
        self.field1 = textField.text;
    } else if (textField.tag == 13) {
        self.field2 = textField.text;
    } else if (textField.tag == 14) {
        self.field1r = textField.text;
    } else if (textField.tag == 15) {
        self.field2r = textField.text;
    } else if (textField.tag == 16) {
        self.superField = textField.text;
    }
}

@end
