# MoonPhaseView

MoonPhaseView is a custom UIVew used in iOS which will draw a shadow over a moon image. It was used for a talk on IBDesignable and IBInspectable. When used in Interface Builder in Xcode (version 6 or greater) you can modify the following parameters on the fly:
* Moon phase - number from 0.0 to 1.0 where 0.0 is new moon, 0.5 is full moon, and 1.0 is back to new moon.
* Shadow alpha - opacity of the shadow, 0.6 is about where I like it. range 0.0 to 1.0.
* Shadow color - tint of the shadow. Could have used the alpha from the color but 1) really added color to show it in IB and 2) it's more likely the shadow opacity is what is being changed more so there is easier access with 2 parameters.

## Legal

MIT license
