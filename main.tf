terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-b"
}

resource "yandex_vpc_network" "yc-network" {
  name = "vulnbox-network"
}

resource "yandex_vpc_subnet" "yc-subnet-0" {
  name           = "yc-auto-subnet-0"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.yc-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_instance" "ad-vulnbox" {
  name = "ad-vulnbox"
  hostname = "ad-vulnbox"
  platform_id = "standard-v1"
  zone = "ru-central1-b"
  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    disk_id = yandex_compute_disk.vulnbox-disk.id
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.yc-subnet-0.id}"
    nat = true
  }
  metadata = {
    user-data = "${file("./metadata.yml")}"
  }
  scheduling_policy {
      preemptible = false
    }
  
}
resource "yandex_compute_disk" "vulnbox-disk" {
  name =  "vulnbox-disk"
  size = 40
  type = "network-ssd"
  zone     = "ru-central1-b"
  image_id = "fd8dfiq123s8j82s85il" # Debian 12
}

output "connect_data" {
  value = yandex_compute_instance.ad-vulnbox.network_interface
  # TODO: Try this https://terraform-provider.yandexcloud.net/Resources/compute_instance#attributes-reference
  # value = yandex_compute_instance.ad-vulnbox.network_interfacee.0.nat_ip_addres
  description = "ip addr"
}