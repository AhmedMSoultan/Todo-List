//
//  DoneViewController.m
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import "DoneViewController.h"
#import "todoItem.h"
#import "EditViewController.h"

@interface DoneViewController ()

@end

@implementation DoneViewController

NSUserDefaults *doneDefaults;
NSMutableArray <todoItem*> *doneCellItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_doneTable setDelegate:self];
    [_doneTable setDataSource:self];
    // Do any additional setup after loading the view.
//    doneCellItems = [NSMutableArray new];
    
    doneDefaults = [NSUserDefaults standardUserDefaults];
}

- (void)viewWillAppear:(BOOL)animated{
    doneCellItems = [NSMutableArray new];
    NSData *savedData = [doneDefaults objectForKey:@"doneItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *items = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [doneCellItems addObjectsFromArray:items];
    
    [self.doneTable reloadData];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];

    cell.textLabel.text = doneCellItems[indexPath.row].name;

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [doneCellItems count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You already done this task." message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:NULL];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:NULL];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Do you want to delete" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [doneCellItems removeObjectAtIndex:indexPath.row];
            NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:doneCellItems requiringSecureCoding:YES error:NULL];
            [doneDefaults setObject:archivedData forKey:@"doneItems"];
            [doneDefaults synchronize];
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

@end
