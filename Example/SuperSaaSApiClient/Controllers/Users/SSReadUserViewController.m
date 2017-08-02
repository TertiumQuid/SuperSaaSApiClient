//
//  SSReadUserViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadUserViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

@interface SSReadUserViewController ()

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *apiResponse;

@end

@implementation SSReadUserViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.placeholder = @"User ID";
            cell.textField.tag = 0;
            return cell;
        } else if (indexPath.row == 2) {
            return [self getButtonCell:tableView forIndexPath:indexPath];
        }
    } if (indexPath.section == 1) {
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
        [SSApiClient readUser:self.userId
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
    self.userId = textField.text;
}

@end
