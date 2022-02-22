//
//  TodoViewController.m
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import "TodoViewController.h"
#import "todoItem.h"
#import "AddViewController.h"
#import "EditViewController.h"

@interface TodoViewController ()

@end

@implementation TodoViewController


NSMutableArray <todoItem*> *todoList;
NSString *dateTime;
NSUserDefaults *userdefaults;

NSMutableArray <todoItem*> *filteredArray;
BOOL isFiltered;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchBar.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-DD  hh:mm:ss"];
    dateTime = [formatter stringFromDate:now];
    
    todoList = [NSMutableArray new];
    userdefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *savedData = [userdefaults objectForKey:@"todoItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [todoList addObjectsFromArray:itemsArray];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isFiltered){
//        return  filteredArray.count;
        return [filteredArray count];
    }
//    return todoList.count;
    return [todoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCell" forIndexPath:indexPath];
    
    if (isFiltered){
        cell.textLabel.text = filteredArray[indexPath.row].name;
    }else{
        cell.textLabel.text = todoList[indexPath.row].name;
    }
    
    // Configure the cell...
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Do you want to delete" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [todoList removeObjectAtIndex:indexPath.row];
            NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:todoList requiringSecureCoding:YES error:NULL];
            [userdefaults setObject:archivedData forKey:@"todoItems"];
            [userdefaults synchronize];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"editVC"];
    [todoList objectAtIndex:indexPath.row].key = @"todoItems";
    [todoList objectAtIndex:indexPath.row].itemIndex = (int)indexPath.row;
    
    editVC.cellItem = [todoList objectAtIndex:indexPath.row];
    
    [todoList removeObjectAtIndex:indexPath.row];
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:todoList requiringSecureCoding:YES error:NULL];
    [userdefaults setObject:archivedData forKey:@"todoItems"];
    [userdefaults synchronize];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [editVC setEdit_delegate:self];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (IBAction)addBtnMethod:(id)sender {
    AddViewController *addVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addVC"];
    [addVC setAdd_delegate:self];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

- (void)addNewTask{
    todoList = [NSMutableArray new];
    NSData *savedData = [userdefaults objectForKey:@"todoItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [todoList addObjectsFromArray:itemsArray];
    [self.tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText{
    if(searchText.length == 0){
        isFiltered = NO;
        [self.searchBar endEditing:YES];
    }else{
        isFiltered = YES;
        filteredArray = [[NSMutableArray alloc] init];
        
        for(todoItem *filteredItem in todoList){
            NSRange range = [filteredItem.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(range.location != NSNotFound){
                [filteredArray addObject:filteredItem];
            }
        }
    }
    [self.tableView reloadData];
}


- (void)doneTask{
    todoList = [NSMutableArray new];
    NSData *savedData = [userdefaults objectForKey:@"todoItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [todoList addObjectsFromArray:itemsArray];
    [self.tableView reloadData];
}

- (void)editTask{
    todoList = [NSMutableArray new];
    NSData *savedData = [userdefaults objectForKey:@"todoItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [todoList addObjectsFromArray:itemsArray];
    [self.tableView reloadData];
}

- (void)inProgressTask{
    todoList = [NSMutableArray new];
    NSData *savedData = [userdefaults objectForKey:@"todoItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [todoList addObjectsFromArray:itemsArray];
    [self.tableView reloadData];
}



//-(void)initializeList{
//    todoItem *item1 = [todoItem new];
//    item1.name = @"Fix Car";
//    item1.descrip = @"med";
//    item1.priority = @"";
//    item1.priorityImg = [UIImage imageNamed:@"MedP"];
//    item1.date = dateTime;
//    NSLog(@"%@",dateTime);
//    [todoList addObject:item1];
//
//    todoItem *item2 = [todoItem new];
//    item2.name = @"Project";
//    item2.descrip = @"high";
//    item2.priority = @"";
//    item2.priorityImg = [UIImage imageNamed:@"HighP"];
//    item2.date = dateTime;
//    NSLog(@"%@",dateTime);
//    [todoList addObject:item2];
//
//
//    todoItem *item3 = [todoItem new];
//    item3.name = @"Clean Clothes";
//    item3.descrip = @"low";
//    item3.priority = @"";
//    item3.priorityImg = [UIImage imageNamed:@"LowP"];
//    item3.date = dateTime;
//    NSLog(@"%@",dateTime);
//    [todoList addObject:item3];
//
//    todoItem *item4 = [todoItem new];
//    item4.name = @"Call customer service";
//    item4.descrip = @"med";
//    item4.priority = @"";
//    item4.priorityImg = [UIImage imageNamed:@"MedP"];
//    item4.date = dateTime;
//    NSLog(@"%@",dateTime);
//    [todoList addObject:item4];
//}

@end
