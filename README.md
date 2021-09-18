# Spinner

## About

Spinner is an activity indicator spins while an unquantifiable task, such as loading or synchronizing complex data, is performed. It disappears when the task completes

## Steps

Spinner mainly deals with layers by adding, removing and animate them

Create LoadingView
- Create SpinnerView and add it to tableview
- create main layer to add it to SpinnerView and animate it with infinity repeation
- create 2 sublayer part of oval with arrow at end of it 
- add the 2 sublayers to main layer

SuccessView

when the task finished I needed to remove loadingView and show success one
- remove sublayers of main layer
- stop main layer animation
- create success layer and add success layer to main layer with animation for checkmark layer
- when animation finish remove sublayers of spinnerView layer
- remove spinnerView from tableView


## Screenshot

<img src="https://user-images.githubusercontent.com/44899782/133910817-82e244be-e6d9-439c-bf3c-e68601b7785f.gif" height = 200 />
