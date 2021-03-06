// RUN: %target-swift-frontend %s -emit-ir -g -o - | FileCheck %s
public struct Q<T> {
  let x: T
}
public func foo<T>(arg: [Q<T>]) {
  // CHECK: define {{.*}}_TF12generic_arg43foourFGSaGVS_1Qx__T_
  // CHECK: store %[[TY:.*]]* %0, %[[TY]]** %[[ALLOCA:.*]], align
  // CHECK: call void @llvm.dbg.declare(metadata %[[TY]]** %[[ALLOCA]],
  // CHECK-SAME:       metadata ![[ARG:.*]], metadata ![[EXPR:.*]])
  // No deref here: the array argument is passed by value.
  // CHECK: ![[EXPR]] = !DIExpression()
  // CHECK: ![[ARG]] = !DILocalVariable(name: "arg", arg: 1,
  // CHECK-SAME:                        line: 5,
  // CHECK-SAME:   type: !"_TtGSaGV12generic_arg41QQq_FS_3foourFGSaGS0_x__T___")
}
