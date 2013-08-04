//
//  ViewController.h
//  FirstiOS
//
//  Created by Gavroche Thenardier on 10.07.13.
//  Copyright (c) 2013 Grantaire. All rights reserved.
//

#import <UIKit/UIKit.h>
// #import <CodeViewController.h>

// Додаємо у <>
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
// {

- (void) methodFor: (int) page;

@property (strong, nonatomic) NSMutableArray *loginsArray;
@property (strong, nonatomic) NSMutableArray *idArray;

@property(nonatomic, strong) IBOutlet UILabel *loginLabel;
@property(nonatomic, strong) IBOutlet UILabel *idLabel;

@end
