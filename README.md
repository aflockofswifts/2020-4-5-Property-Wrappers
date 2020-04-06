# 2020-4-5-Property-Wrappers
Demo project for 2020-4-5 Meetup on Property Wrappers

The main take away here should be that the projected values for `@State` and `@Binding` are a `Binding` while the projected values for `@ObservedObject` and `@EnvironmentObject` are a `Wrapper` which will return a `Binding` through `@dynamicMemberLookup` on a keypath.  The projected value for `@Published` is a `Publisher`.
