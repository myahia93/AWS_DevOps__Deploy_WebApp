# Security Group
resource "aws_security_group" "sg-asg" {
  name        = "SG-ASG"
  description = "Allow 8080 inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description     = "8080 from ELastic Load Balancer"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [var.__elb_sg_id]
  }

  tags = {
    Name = "SG-ASG"
  }
}

# Auto Scaling Group
resource "aws_launch_configuration" "as_conf" {
  name            = "${var.__webapp_name}_config"
  image_id        = data.aws_ami.webapp.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg-asg.id]
}
resource "aws_autoscaling_group" "asg" {
  name             = "asg-${var.__webapp_name}"
  min_size         = 3
  desired_capacity = 3
  max_size         = 3

  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.as_conf.name

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"

  vpc_zone_identifier = data.aws_subnet.snet-private.*.id
  load_balancers      = [var.__elb_id]
}

# Autoscaling Policy
resource "aws_autoscaling_policy" "webapp_policy_up" {
  name                   = "${var.__webapp_name}_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
resource "aws_autoscaling_policy" "webapp_policy_down" {
  name                   = "${var.__webapp_name}_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

# Cloudwatch Alarm
resource "aws_cloudwatch_metric_alarm" "webapp_cpu_alarm_up" {
  alarm_name          = "${var.__webapp_name}_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.webapp_policy_up.arn]
}
resource "aws_cloudwatch_metric_alarm" "webapp_cpu_alarm_down" {
  alarm_name          = "${var.__webapp_name}_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.webapp_policy_down.arn]
}
