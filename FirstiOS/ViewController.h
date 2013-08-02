//
//  ViewController.h
//  FirstiOS
//
//  Created by Gavroche Thenardier on 10.07.13.
//  Copyright (c) 2013 Grantaire. All rights reserved.
//

#import <UIKit/UIKit.h>

// Додаємо у <>
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
// {

- (void) methodFor: (int) page;

// Додаток 1
@property (strong, nonatomic) NSMutableArray *loginsArray;
@property (strong, nonatomic) NSMutableArray *idArray;

//

@end
