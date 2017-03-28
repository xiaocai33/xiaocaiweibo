//
//  WBHomeTableViewController.m
//  小蔡微博
//
//  Created by 小蔡 on 2017/3/24.
//  Copyright © 2017年 xiaocai. All rights reserved.
//

#import "WBHomeTableViewController.h"
#import "UIBarButtonItem+Extent.h"
#import "UIView+UIView_Extent.h"
#import "WBButton.h"

@interface WBHomeTableViewController ()

@end


@implementation WBHomeTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏右侧的按钮
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_pop"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClcik)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithImage:@"navigationbar_pop" highltImage:@"navigationbar_pop_highlighted" target:self action:@selector(rightBarButtonClick)];
    
    //设置导航栏左侧的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"navigationbar_friendsearch" highltImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(leftBarButtonClick)];
    
    //设置中间按钮
    WBButton *btn = [WBButton buttonWithTitle:@"首页" upImage:@"navigationbar_arrow_up" downImage:@"navigationbar_arrow_down"];
    //按钮设置文字要用setTitle设置在那种状态下的文字显示,不能用titleLabel.text设置
//    [btn setTitle:@"首页" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btn.size = CGSizeMake(50, 50);
//    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = btn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarButtonClick{
    NSLog(@"rightBarButtonClick");
}

- (void)leftBarButtonClick{
    NSLog(@"leftBarButtonClick");
}

- (void)homeBtnClick{
    NSLog(@"homeButtonClick");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellString];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"tableCell%ld", indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
