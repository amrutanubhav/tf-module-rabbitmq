resource "aws_spot_instance_request" "rabbitmq" {
  ami                       = data.aws_ami.image.id
  instance_type             = "t3.micro"
  subnet_id                 = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]
  vpc_security_group_ids    = [aws_security_group.allow_rabbit.id]
  wait_for_fulfillment      = true
  iam_instance_profile    = "b52-FA"


  tags = {
    Name = "rabbitmq-${var.ENV}"
  }
}

#installing rabbitmq

resource "null_resource" "app" {
    

#       triggers = {
#     # version = var.APP_VERSION   #only when there is a change in the value of APP_VERSION compated to previous verion, then only this will be triggered.
#       timechange = timestamp()   # Since the time changes all the time, it's going to run all the time.
#   }
    # count = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  
   provisioner "remote-exec" {

        connection {
          type     = "ssh"
          user     = local.SSH_USER
          password = local.SSH_PASS
          host     = aws_spot_instance_request.rabbitmq.private_ip
        }

              inline = [
                "ansible-pull -U https://github.com/amrutanubhav/robohop-plays.git -e component=rabbitmq -e env=dev robot-pull.yml"
              ]

 
  }
}