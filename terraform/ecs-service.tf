resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service-rupesh"
  cluster         = aws_ecs_cluster.strapi_cluster.id
  launch_type     = "FARGATE"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.strapi_task.arn

  network_configuration {
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id] # Replace with actual subnet resource names
    security_groups  = [aws_security_group.strapi_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi_tg.arn
    container_name   = "strapi"
    container_port   = 1337
  }

  depends_on = [
    aws_lb_listener.strapi_listener
  ]
}
