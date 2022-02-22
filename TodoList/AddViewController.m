//
//  AddViewController.m
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import "AddViewController.h"
#import "todoItem.h"

@interface AddViewController () 

@end

@implementation AddViewController

NSString *reminderDateTime;
NSString *currentDateTime;
NSString *taskPriority;
todoItem *newItem;
NSUserDefaults *defaults;
NSMutableArray *arrayItems;

NSMutableArray<todoItem*> *todoItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-DD  hh:mm:ss"];
    currentDateTime = [formatter stringFromDate:now];
    _dateLabel.text = [formatter stringFromDate:now];
    
    arrayItems = [NSMutableArray new];
    todoItems = [NSMutableArray new];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *savedData = [defaults objectForKey:@"todoItems"];
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[todoItem class]]];
    NSArray<todoItem*> *itemsArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:nil];
    
    [todoItems addObjectsFromArray:itemsArray];
    
    [_priorityPicker setDelegate:self];
    [_priorityPicker setDataSource:self];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (row) {
        case 0:
            taskPriority = @"High";
            break;
        case 1:
            taskPriority = @"Meduim";
            break;
        case 2:
            taskPriority = @"Low";
            break;
    }
    return taskPriority;
}

-(void) dueDateChanged:(UIDatePicker *)sender {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
    currentDateTime = [dateFormatter stringFromDate:[sender date]];
}


- (IBAction)addMethod:(id)sender {
    newItem = [todoItem new];
    newItem.name = _nameTf.text;
    newItem.descrip = _descriptionTf.text;
    newItem.priority = taskPriority;
    newItem.date = currentDateTime;
    
    [todoItems addObject:newItem];
    
    
//    //Notification
//    NSTimeInterval startTime =[currentDateTime timeIntervalSinceDate:reminderDateTime];
//
//    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:startTime]; //Enter the time here in seconds.
//    localNotification.alertBody = self.nameOfToDo.text;
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    
//    //End Notification
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:todoItems requiringSecureCoding:YES error:Nil];
    [defaults setObject:archiveData forKey:@"todoItems"];
    [defaults synchronize];
    [_add_delegate addNewTask];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//
//{
//
//    [defaults setBool:YES forKey:@"notificationIsActive"];
//    [defaults synchronize];
//
//
//    NSString *str1 = _dateSelection.text;
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate *dte1 = [dateFormat dateFromString:str1];
//
//
//
//    NSString *str2 = [dateFormat stringFromDate:[NSDate date]];
//    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
//    [dateFormat1 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate *dte2 = [dateFormat1 dateFromString:str2];
//
//    NSTimeInterval startTime =[dte1 timeIntervalSinceDate:dte2];
//
//    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:startTime]; //Enter the time here in seconds.
//    localNotification.alertBody = self.nameOfToDo.text;
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//
//}

+ (BOOL)supportsSecureCoding{
    return  YES;
}


@end
