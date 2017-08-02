//
//  SSFormViewController.h
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSTableViewController.h"
#import "SSTextFieldTableViewCell.h"

@interface SSFormViewController : SSTableViewController <UITextFieldDelegate>

- (void) showAlert:(NSString *)title withMessage:(NSString *)message;

- (SSTextFieldTableViewCell *) getResponseCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath withText:(NSString *)text;
- (UITableViewCell *) getButtonCell:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
    
@end
