//
//  editDelegate.h
//  TodoList
//
//  Created by Ahmed Soultan on 30/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol editDelegate <NSObject>

//-(void) editTask:(NSNumber*) itemIndex forKey: (NSString*) dataKey;
//-(void) inProgressTask:(NSNumber*) itemIndex forKey: (NSString*) dataKey;
//-(void) doneTask:(NSNumber*) itemIndex forKey: (NSString*) dataKey;

-(void) editTask;
-(void) inProgressTask;
-(void) doneTask;

@end

NS_ASSUME_NONNULL_END
