//
//  EditViewController.h
//  TodoList
//
//  Created by Ahmed Soultan on 30/01/2022.
//

#import <UIKit/UIKit.h>
#import "editDelegate.h"
#import "todoItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *descripTf;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property todoItem *cellItem;

@property id<editDelegate> edit_delegate;

@end

NS_ASSUME_NONNULL_END
