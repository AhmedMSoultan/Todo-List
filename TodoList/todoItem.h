//
//  todoItem.h
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import <Foundation/Foundation.h>
#import "UiKit/UiKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface todoItem : NSObject <NSCoding,NSSecureCoding>

@property NSString *name;
@property NSString *descrip;
@property NSString *priority;
@property UIImage *priorityImg;
@property NSString *date;
@property int itemIndex;
@property NSString *key;


@end

NS_ASSUME_NONNULL_END
