module "load_balancer" {
  source = "./modules/load_balancer"

  __az          = var.az
  __webapp_name = var.webapp_name
}

module "autoscaling" {
  source = "./modules/autoscaling"

  __az          = var.az
  __webapp_name = var.webapp_name
  __elb_sg_id   = module.load_balancer.sg_id
  __elb_id      = module.load_balancer.elb_id
}
