//
//  SSReadUsersViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadUsersViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

@interface SSReadUsersViewController ()

@property (nonatomic, strong) NSNumber *limit;
@property (nonatomic, strong) NSNumber *offset;
@property (nonatomic, strong) NSString *apiResponse;
    
@end

@implementation SSReadUsersViewController
    
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
            cell.textField.placeholder = @"Limit";
            cell.textField.tag = 0;
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.placeholder = @"Offset";
            cell.textField.tag = 1;
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
        [SSApiClient readUsers:self.limit
                        offset:self.offset
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
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    NSNumber *number = [formatter numberFromString:textField.text];
    
    if (textField.tag == 0) {
        self.limit = number;
    } else if (textField.tag == 1) {
        self.offset = number;
    }
}
    
@end
