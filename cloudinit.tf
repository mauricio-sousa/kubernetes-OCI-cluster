locals {
  packages = [
    "apt-transport-https",
    "build-essential",
    "ca-certificates",
    "curl",
    "docker.io",
    "jq",
    "kubeadm",
    "kubelet",
    "lsb-release",
    "make",
    "prometheus-node-exporter",
    "python3-pip",
    "software-properties-common",
    "tmux",
    "tree",
    "unzip",
  ]
}

data "cloudinit_config" "_" {
  for_each = local.nodes

  part {
    filename     = "cloud-config.cfg"
    content_type = "text/cloud-config"
    content      = <<-EOF
      hostname: ${each.value.node_name}
      package_update: true
      package_upgrade: false
      packages:
      ${yamlencode(local.packages)}
      apt:
        sources:
          kubernetes.list:
            source: "deb https://apt.kubernetes.io/ kubernetes-xenial main"
            key: |
              -----BEGIN PGP PUBLIC KEY BLOCK-----

              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
              =pRoV
              -----END PGP PUBLIC KEY BLOCK-----
      users:
      - default
      - name: k8s
        primary_group: k8s
        groups: docker
        home: /home/k8s
        shell: /bin/bash
        sudo: ALL=(ALL) NOPASSWD:ALL
        ssh_authorized_keys:
        - ${tls_private_key.ssh.public_key_openssh}
      write_files:
      - path: /etc/kubeadm_token
        owner: "root:root"
        permissions: "0600"
        content: ${local.kubeadm_token}
      - path: /etc/kubeadm_config.yaml
        owner: "root:root"
        permissions: "0600"
        content: |
          kind: InitConfiguration
          apiVersion: kubeadm.k8s.io/v1beta2
          bootstrapTokens:
          - token: ${local.kubeadm_token}
          ---
          kind: KubeletConfiguration
          apiVersion: kubelet.config.k8s.io/v1beta1
          cgroupDriver: cgroupfs
          ---
          kind: ClusterConfiguration
          apiVersion: kubeadm.k8s.io/v1beta2
          apiServer:
            certSANs:
            - @@PUBLIC_IP_ADDRESS@@
      - path: /home/k8s/.ssh/id_rsa
        defer: true
        owner: "k8s:k8s"
        permissions: "0600"
        content: |
          ${indent(4, tls_private_key.ssh.private_key_pem)}
      - path: /home/k8s/.ssh/id_rsa.pub
        defer: true
        owner: "k8s:k8s"
        permissions: "0600"
        content: |
          ${indent(4, tls_private_key.ssh.public_key_openssh)}
      EOF
  }

  # By default, all inbound traffic is blocked
  # (except SSH) so we need to change that.
  part {
    filename     = "allow-inbound-traffic.sh"
    content_type = "text/x-shellscript"
    content      = <<-EOF
      #!/bin/sh
      iptables -I INPUT -p tcp -s 10.0.0.0/16 -j ACCEPT
      iptables -I INPUT -p tcp -s ${local.ifconfig_co_json.ip_addr} -j ACCEPT
      sed -i "s/-A INPUT -j REJECT --reject-with icmp-host-prohibited//" /etc/iptables/rules.v4 
      netfilter-persistent start
    EOF
  }

  dynamic "part" {
    for_each = each.value.role == "controlplane" ? ["yes"] : []
    content {
      filename     = "kubeadm-init.sh"
      content_type = "text/x-shellscript"
      content      = <<-EOF
        #!/bin/sh
        PUBLIC_IP_ADDRESS=$(curl https://icanhazip.com/)
        sed -i s/@@PUBLIC_IP_ADDRESS@@/$PUBLIC_IP_ADDRESS/ /etc/kubeadm_config.yaml
        kubeadm init --config=/etc/kubeadm_config.yaml --ignore-preflight-errors=NumCPU
        export KUBECONFIG=/etc/kubernetes/admin.conf
        kubever=$(kubectl version | base64 | tr -d '\n')
        kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=$kubever
        mkdir -p /home/k8s/.kube
        cp $KUBECONFIG /home/k8s/.kube/config
        chown -R k8s:k8s /home/k8s/.kube
      EOF
    }
  }

  dynamic "part" {
    for_each = each.value.role == "worker" ? ["yes"] : []
    content {
      filename     = "kubeadm-join.sh"
      content_type = "text/x-shellscript"
      content      = <<-EOF
      #!/bin/sh
      KUBE_API_SERVER=${local.nodes[1].ip_address}:6443
      while ! curl --insecure https://$KUBE_API_SERVER; do
        echo "Kubernetes API server ($KUBE_API_SERVER) not responding."
        echo "Waiting 10 seconds before we try again."
        sleep 10
      done
      echo "Kubernetes API server ($KUBE_API_SERVER) appears to be up."
      echo "Trying to join this node to the cluster."
      kubeadm join --discovery-token-unsafe-skip-ca-verification --token ${local.kubeadm_token} $KUBE_API_SERVER
    EOF
    }
  }
}

#data "http" "apt_repo_key" {
#  url = "https://packages.cloud.google.com/apt/doc/apt-key.gpg.asc"
#}

# The kubeadm token must follow a specific format:
# - 6 letters/numbers
# - a dot
# - 16 letters/numbers

resource "random_string" "token1" {
  length  = 6
  number  = true
  lower   = true
  special = false
  upper   = false
}

resource "random_string" "token2" {
  length  = 16
  number  = true
  lower   = true
  special = false
  upper   = false
}

locals {
  kubeadm_token = format(
    "%s.%s",
    random_string.token1.result,
    random_string.token2.result
  )
}

data "http" "client_current_pub_ip" {
  url = "https://ifconfig.me/all.json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ifconfig_co_json = jsondecode(data.http.client_current_pub_ip.body)
}