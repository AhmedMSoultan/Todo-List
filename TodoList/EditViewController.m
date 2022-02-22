//
//  EditViewController.m
//  TodoList
//
//  Created by Ahmed Soultan on 30/01/2022.
//

#import "EditViewController.h"
#import "todoItem.h"

@interface EditViewController ()

@end

@implementation EditViewController

NSString *newTaskPriority;
NSString *editDateTime;
NSString *key;
int indexPath;

NSMutableArray <todoItem*> *todoLisItems;
NSMutableArray <todoItem*> *inProgressItems;
NSMutableArray <todoItem*> *doneItems;

NSUserDefaults *editDefaults;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    todoLisItems = [NSMutableArray new];
    inProgressItems = [NSMutableArray new];
    doneItems =[NSMutableArray new];
    
    [_priorityPicker setDelegate:self];
    [_priorityPicker setDataSource:self];
    
    
    _nameTf.text = _cellItem.name;
    _descripTf.text = _cellItem.descrip;
    newTaskPriority = _cellItem.priority;
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-DD  hh:mm:ss"];
    editDateTime = [formatter stringFromDate:now];
    _dateTimeLabel.text = editDateTime;
    
    editDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *savedData = [editDefaults objectForKey:@"todoItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    [todoLisItems addObjectsFromArray:itemsArray];
    
    savedData = [editDefaults objectForKey:@"inProgressItems"];
    set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    [inProgressItems addObjectsFromArray:itemsArray];
    
    savedData = [editDefaults objectForKey:@"doneItems"];
    set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    [doneItems addObjectsFromArray:itemsArray];
    
    
    
    
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    switch (row) {
        case 0:
            newTaskPriority = @"High";
            break;
        case 1:
            newTaskPriority = @"Meduim";
            break;
        case 2:
            newTaskPriority = @"Low";
            break;
    }
    return newTaskPriority;
}


- (IBAction)editBtnMethod:(id)sender {
    todoItem *editedItem = [todoItem new];
    editedItem.name = _nameTf.text;
    editedItem.descrip = _descripTf.text;
    editedItem.priority = newTaskPriority;
    editedItem.date = editDateTime;
    editedItem.key = _cellItem.key;
    editedItem.itemIndex = _cellItem.itemIndex;
    
    if([_cellItem.key isEqualToString:@"inProgressItems"]){
        [inProgressItems addObject:editedItem];
        NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:inProgressItems requiringSecureCoding:YES error:Nil];
        [editDefaults setObject:archiveData forKey:@"inProgressItems"];
        [editDefaults synchronize];
    }else{
        [todoLisItems addObject:editedItem];
        NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:todoLisItems requiringSecureCoding:YES error:Nil];
        [editDefaults setObject:archiveData forKey:@"todoItems"];
        [editDefaults synchronize];
    }
    [_edit_delegate editTask];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)willMoveToParentViewController:(UIViewController *)parent{ // will handle back button in navigation bar
    
}
- (IBAction)inProgressBtnMethod:(id)sender {
    
    todoItem *progressAddedItem = [todoItem new];
    progressAddedItem.name = _nameTf.text;
    progressAddedItem.descrip = _descripTf.text;
    progressAddedItem.priority = newTaskPriority;
    progressAddedItem.date = editDateTime;
    
    [inProgressItems addObject:progressAddedItem];
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:inProgressItems requiringSecureCoding:YES error:Nil];
    [editDefaults setObject:archiveData forKey:@"inProgressItems"];
    [editDefaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneBtnMethod:(id)sender {
    
    todoItem *doneAddedItem = [todoItem new];
    doneAddedItem.name = _nameTf.text;
    doneAddedItem.descrip = _descripTf.text;
    doneAddedItem.priority = newTaskPriority;
    doneAddedItem.date = editDateTime;
    
    [doneItems addObject:doneAddedItem];
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:doneItems requiringSecureCoding:YES error:Nil];
    [editDefaults setObject:archiveData forKey:@"doneItems"];
    [editDefaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
