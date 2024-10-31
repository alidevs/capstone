data "alicloud_zones" "available" {
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_efficiency"
}

