# Spinner

## About

Spinner is an activity indicator that spins while an unquantifiable task, such as loading or synchronizing complex data, is performed. It disappears when the task completes

## Steps

Spinner mainly deals with layers by adding, removing, and animate them

### Create LoadingView
- Create SpinnerView and add it to tableView
- create main layer to add it to SpinnerView and animate it with infinity repetition
- create 2 sublayers part of oval with an arrow at end of it 
- add the 2 sublayers to the main layer

### SuccessView

when the task finished I needed to remove loadingView and show success one
- remove sublayers of main layer
- stop main layer animation
- create success layer and add success layer to main layer with animation for checkmark layer
- when animation finish remove sublayers of spinnerView layer
- remove spinnerView from tableView


## Screenshot

<img src="https://user-images.githubusercontent.com/44899782/133911207-c2d90e60-590b-4f00-9851-57221b20d7c4.gif" height = 200 />
