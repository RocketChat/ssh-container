# SSH Container

Alpine Linux docker image with SSH support.

Also adds the public SSH key to the host's `~/.ssh/authorized_keys`

Please check docker logs for random generated root password or set authorized_keys via PUBLIC_SSH_KEYS environment variable.

## Docker Cloud example
Create a Stack file as the following:
```
ssh-container:
  image: rocketchat/ssh-container
  deployment_strategy: every_node
  autodestroy: always
  environment:
    - AUTHORIZED_KEYS=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4PHh4WJqUgiWedmkIJS+L1IwxfXHkfYC0N9NZ28quXyL4zQq2CDeCQrS0RDESklnuZVCe9p5fjgEHcy+FsiTUaBbjzCndeO++gqAM6pKy4ziEY1JNpIBpbuyVIK6AJIqTWzcqprhw4G8PZetLoHaiTh343wsIW7WHhNNsrEVEsTCnCc5vG97IHZ0A6TlP6HGvVSfCFPZiAxP48hsoEsEGjcCvY9tgJa4k60XWtHbPWtjOi90RFt9OKcbUsZa+vq/3lBG50XbMoQm3NS6A+UQQ7SKvzmwJSIYCqo5lu9UzQbVKy9o00NqXa5jkmZ9Yd0BJBjFmb3WwUR8sJWZVTPFL
  volumes:
    - /root:/user:rw
```
