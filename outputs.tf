output "node_1_ip" {
    value = aws_instance.node[0].public_ip
    description = "blah"
}

output "node_2_ip" {
    value = aws_instance.node[1].public_ip
}

output "node_3_ip" {
    value = aws_instance.node[2].public_ip
}

output "crdb_console" {
    value = "http://${aws_instance.node[0].public_ip}:8080"
}