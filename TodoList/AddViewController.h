//
//  AddViewController.h
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import <UIKit/UIKit.h>
#import "todoItem.h"
#import "addDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,NSCoding,NSSecureCoding>

@property todoItem *todoNewItem;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTf;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property id<addDelegate> add_delegate;

@end

NS_ASSUME_NONNULL_END
