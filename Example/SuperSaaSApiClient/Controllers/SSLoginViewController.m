//
//  SSLoginViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SaaS. All rights reserved.
//

#import "SSLoginViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

NSString * const kLoginAccountKey = @"SaaSAccountName";
NSString * const kLoginUserKey = @"SaaSUsername";

@interface SSLoginViewController ()

@property (nonatomic, strong) NSString *userText;
@property (nonatomic, strong) NSString *accountText;
@property (nonatomic, strong) NSString *passwordText;
    
@end

@implementation SSLoginViewController
    
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
        return @"Enter Your User and Account Details";
    } else {
        return @"";
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (indexPath.section == 0) {
        static NSString *cellId = @"TextFieldCell";
        if (indexPath.row == 0) {
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                           forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Username";
            cell.textField.text = [defaults stringForKey:kLoginUserKey];
            cell.textField.tag = 0;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        } else if (indexPath.row == 1) {
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Account Name";
            cell.textField.text = [defaults stringForKey:kLoginAccountKey];
            cell.textField.tag = 1;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        } else if (indexPath.row == 2) {
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Account Password";
            cell.textField.secureTextEntry = YES;
            cell.textField.tag = 2;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        }
    } if (indexPath.section == 1) {
        UITableViewCell *cell = [self getButtonCell:tableView forIndexPath:indexPath];
        cell.textLabel.text = @"Login to SuperSaaS";
        return cell;
    }
    return nil;
}
    
#pragma mark - Table view delegate
    
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.userText forKey:kLoginUserKey];
        [defaults setObject:self.accountText forKey:kLoginAccountKey];
        [defaults synchronize];

        [SSApiClient login:self.userText
               accountName:self.accountText
           accountPassword:self.passwordText
                   success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [self dismissViewControllerAnimated:NO completion:nil];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self dismissViewControllerAnimated:NO completion:nil];
            
        }];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Text field delegate
    
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.userText = textField.text;
    } else if (textField.tag == 1) {
        self.accountText = textField.text;
    } else if (textField.tag == 2) {
        self.passwordText = textField.text;
    }
}

@end
