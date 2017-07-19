/*
  Create Elastic File System (EFS) resource
*/
resource "aws_efs_file_system" "efs" {
  creation_token = "${var.creation_token}"

  tags {
    Name = "${var.creation_token}"
  }
}

/*
  Provides an Elastic File System (EFS) mount target
*/
resource "aws_efs_mount_target" "efs_mount" {

  /* create resource for each subnet */
  count = "${length(var.subnets)}"

  file_system_id = "${aws_efs_file_system.efs.id}"

  /* subnet to attach to */
  subnet_id = "${element(var.subnets, count.index)}"
}
