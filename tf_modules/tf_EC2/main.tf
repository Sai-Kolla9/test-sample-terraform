resource "aws_instance" "test_example" {
    ami           = var.ami_id
    instance_type = "t2.micro"

    tags = {
        Name = "ExampleInstance"
    }
}