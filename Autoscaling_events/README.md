## Call Lambda on autoscaling event
Code in this directory perform following steps:
* Create a Amazon SNS topic
* Configure Auto Scaling to send events
* Create an IAM role for the AS Lambda function
* Create an AWS Lambda function
* Trigger Auto Scaling to scale-out
