resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "strapi-task-rupesh"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "strapi"
    image     = "${aws_ecr_repository.strapi.repository_url}:latest"
    essential = true

    portMappings = [{
      containerPort = 1337
      hostPort      = 1337
    }],

    environment = [
      { name = "APP_KEYS", value = "U7z+M5LjmLUq2UrKQRyo0A==,MbAH1M8296sS2v1UruVhgQ==,L+4PQ2tv2Oe351sy8uEbEQ==,pXqEnMmtq7ehDWufOFldaw==" },
      { name = "API_TOKEN_SALT", value = "wnGEaaGa3y8sEqiw3Mme5w==" },
      { name = "ADMIN_JWT_SECRET", value = "/fi0Raq7p1My7zTuA+BPkQ==" },
      { name = "TRANSFER_TOKEN_SALT", value = "Lg1Mz/jKrx6GrO2RVICbKw==" },
      { name = "ENCRYPTION_KEY", value = "MEGtAmPK2I9sSEHPDfrgFw==" },
      { name = "JWT_SECRET", value = "3xyoZFbtWKZMgc0wMx611Q==" }
    ],

    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = "/ecs/strapi"
        awslogs-region        = "us-east-2"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}
