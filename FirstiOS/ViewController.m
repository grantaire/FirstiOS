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


// Метод, що корнвертує дані з JSON

- (void) methodFor: (int) page
{
    NSString *gitPage = [NSString stringWithFormat:@"https://api.github.com/gists?page=%d", page];

    NSData *repData = [NSData dataWithContentsOfURL: [NSURL URLWithString: gitPage]];
    
    //
    NSError *error = nil;
    
    // Converting JSON to Foundation object
    NSArray *convertedObject = [NSJSONSerialization
                                JSONObjectWithData: repData options: 0 error: &error];
    
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


// Метод, що повинен викликати methodFor для відображення даних

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view, typically from a nib.
    
    
       // Це треба, щоб зчитувалсь дані, інакше масив пустий.
    loginsArray = [NSMutableArray array];
    idArray = [NSMutableArray array];
    
    
    
    [self methodFor: 0];

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
    
    /*
    for(id lastObject in )
    {
        [tableView reloadData];
    }
    */
    
    return cell;
}

 // Метод, що підвантажує сторінки, але він ще не дописаний, я його зміню, коли зрозумію, як викликати метод з методу
 
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > loginsArray.count)
    {
        int plus1 = loginsArray.count/30;
        
        [self methodFor: plus1];
    }
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



