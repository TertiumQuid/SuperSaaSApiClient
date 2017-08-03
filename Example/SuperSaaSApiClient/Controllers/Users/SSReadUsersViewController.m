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
        NSInteger rows = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row < rows - 1) {
            NSString *text = @"";
            if (indexPath.row == 0) {
                text = @"Limit";
            } else if (indexPath.row == 1) {
                text = @"Offset";
            }
        
            return [self getTextFieldCell:tableView
                             forIndexPath:indexPath
                                 withText:text
                                  withTag:indexPath.row];

        } else {
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
    
    self.apiResponse = @"Loading...";
    [self.tableView reloadData];
    
    if (isButtonRow) {
        [SSApiClient readUsers:self.limit
                        offset:self.offset
                   success:^(NSURLSessionDataTask *task, id responseObject) {
                       self.apiResponse = [NSString stringWithFormat:@"%@", responseObject];
                       [self.tableView reloadData];
                       
                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                       [self showApiError:error];
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
