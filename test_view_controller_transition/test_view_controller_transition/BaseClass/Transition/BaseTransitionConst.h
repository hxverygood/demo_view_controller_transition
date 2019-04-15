//
//  BaseTransitionConst.h
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#ifndef BaseTransitionConst_h
#define BaseTransitionConst_h

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypeNone,
    TransitionTypePush,
    TransitionTypePop,
    TransitionTypeTabLeft,
    TransitionTypeTabRight,
    TransitionTypePresent,
    TransitionTypeDismiss
};

#endif /* BaseTransitionConst_h */
