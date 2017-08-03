//
//  SSFormViewController.h
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSTableViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSLabelTableViewCell.h"

@interface SSFormViewController : SSTableViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSString *apiResponse;

- (BOOL) isButtonRow:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
- (void) showAlert:(NSString *)title withMessage:(NSString *)message;
- (void) showApiLoading;
- (void) showApiResponse:(NSDictionary *)responseObject;
- (void) showApiError:(NSError *)error;

- (SSTextFieldTableViewCell *) getTextFieldCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath withText:(NSString *)text withTag:(NSInteger)tag;
- (SSLabelTableViewCell *) getResponseCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath withText:(NSString *)text;
- (UITableViewCell *) getButtonCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

- (NSNumber *) getNumber:(NSString *)text;
- (NSDate *) getDate:(NSString *)text;

@end
