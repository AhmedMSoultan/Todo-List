//
//  InProgressViewController.m
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import "InProgressViewController.h"
#import "todoItem.h"
#import "EditViewController.h"

@interface InProgressViewController ()

@end

@implementation InProgressViewController
{
NSUserDefaults *inProgressDefaults;
NSMutableArray <todoItem*> *inProgressCellItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_progressTable setDelegate:self];
    [_progressTable setDataSource:self];
    
    // Do any additional setup after loading the view.
//    inProgressDefaults = [NSUserDefaults standardUserDefaults];
    
//    NSData *savedData = [inProgressDefaults objectForKey:@"inProgressItems"];
//    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
//    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
//    
//    [inProgressCellItems addObjectsFromArray:itemsArray];
}

- (void)viewWillAppear:(BOOL)animated{
    inProgressCellItems = [NSMutableArray new];
    inProgressDefaults = [NSUserDefaults standardUserDefaults];
    NSData *savedData = [inProgressDefaults objectForKey:@"inProgressItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [inProgressCellItems addObjectsFromArray:itemsArray];
    [self.progressTable reloadData];
}
//- (void)tableView:(UITableView *)progressTable didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    EditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"editVC"];
//
//    //    addVC.todoNewItem = [todoList objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:editVC animated:YES];
//}




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"progressCell" forIndexPath:indexPath];
    
        cell.textLabel.text = inProgressCellItems[indexPath.row].name;
    
        return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return [inProgressCellItems count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"editVC"];
    [inProgressCellItems objectAtIndex:indexPath.row].key = @"inProgressItems";
    [inProgressCellItems objectAtIndex:indexPath.row].itemIndex = (int)indexPath.row;
    
    editVC.cellItem = [inProgressCellItems objectAtIndex:indexPath.row];
    [editVC setEdit_delegate:self];
    
    [inProgressCellItems removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:inProgressCellItems requiringSecureCoding:YES error:Nil];
    [inProgressDefaults setObject:archiveData forKey:@"inProgressItems"];
    [inProgressDefaults synchronize];
    
    [self.navigationController pushViewController:editVC animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Do you want to delete" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [inProgressCellItems removeObjectAtIndex:indexPath.row];
            NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:inProgressCellItems requiringSecureCoding:YES error:NULL];
            [inProgressDefaults setObject:archivedData forKey:@"inProgressItems"];
            [inProgressDefaults synchronize];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:NULL];
        [alert addAction:action];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:NULL];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       
    }
}


- (void)doneTask{
    inProgressCellItems = [NSMutableArray new];
    NSData *savedData = [inProgressDefaults objectForKey:@"inProgressItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    [inProgressCellItems addObjectsFromArray:itemsArray];
    [self.progressTable reloadData];
}

- (void)editTask{
    inProgressCellItems = [NSMutableArray new];
    NSData *savedData = [inProgressDefaults objectForKey:@"inProgressItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    [inProgressCellItems addObjectsFromArray:itemsArray];
    [self.progressTable reloadData];
}

- (void)inProgressTask{
    inProgressCellItems = [NSMutableArray new];
    NSData *savedData = [inProgressDefaults objectForKey:@"inProgressItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    [inProgressCellItems addObjectsFromArray:itemsArray];
    [self.progressTable reloadData];
}


@end
