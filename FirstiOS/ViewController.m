//
//  ViewController.m
//  FirstiOS
//
//  Created by Gavroche Thenardier on 10.07.13.
//  Copyright (c) 2013 Grantaire. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableCell.h"


@interface ViewController ()

@end


@implementation ViewController
{
    NSMutableArray *loginsArray;
    NSMutableArray *idArray;
}


@synthesize loginsArray = loginsArray;
@synthesize idArray = idArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSData *repData = [NSData dataWithContentsOfURL: [NSURL URLWithString: @"https://api.github.com/gists?page=0"]];
    
    
    //
    NSError *error = nil;
    
    // Converting JSON to Foundation object
    NSArray *convertedObject = [NSJSONSerialization
                                JSONObjectWithData: repData options: 0 error: &error];
    
    // Це треба, щоб зчитувалсь дані, інакше масив пустий.
    loginsArray = [NSMutableArray array];
    idArray = [NSMutableArray array];
    
    // Цикл, щоб зчитувались усі дані
    for (NSDictionary *user in convertedObject)
    {
        NSDictionary *userDict = [user objectForKey:@"user"];
        NSString *userID = [NSString stringWithFormat:@"%@", [userDict objectForKey:@"id"]];
        NSString *userLogin = [userDict objectForKey:@"login"];
        [idArray addObject:userID];
        [loginsArray addObject:userLogin];
    }
    
    
    
    if(error)
    {
        NSLog(@"Get error %@", error);
    }
    
    NSLog(@"%@", loginsArray);
    NSLog(@"%@", idArray);

}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [loginsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *firstTableIdentifier = @"FirstTableCell";
    
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstTableIdentifier];
    FirstTableCell *cell = (FirstTableCell *)[tableView dequeueReusableCellWithIdentifier:firstTableIdentifier];
    
    if(cell == nil)
    {
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstTableIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FirstTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    // cell.textLabel.text = [loginsArray objectAtIndex:indexPath.row];
    cell.loginLabel.text = [loginsArray objectAtIndex:indexPath.row];
    cell.idLabel.text = [idArray objectAtIndex:indexPath.row];
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end



