# Network Connectivity Options

Popsink supports secure and private network interconnections to third-party environments, whether on-premises, partner networks, or cloud infrastructures. Two main options are available depending on your architecture and security requirements: **IPSec Site-to-Site VPN** and **VPC Peering (Google Cloud Platform)**.

---

## 1. Site-to-Site VPN (IPSec)

A **Site-to-Site VPN** establishes an encrypted tunnel between Popsink and a third-party network, enabling secure data exchange across infrastructures.

**Purpose:**
To create a secure, encrypted communication channel between Popsink and an external network (client, partner, or remote cloud).

**Technology:**

* **Protocol:** IPSec (Internet Protocol Security)
* **Tunnel Type:** Gateway-to-gateway (Site-to-Site)

**Security Features:**

* **End-to-End Encryption:** IPSec encrypts all data exchanged between sites, ensuring confidentiality and preventing unauthorized interception or inspection.
* **Mutual Authentication:** Gateways authenticate each other using certificates or pre-shared keys (PSK) to ensure authenticity.
* **Data Integrity:** HMAC mechanisms verify that data remains unaltered during transmission.
* **NAT Traversal Support:** Enables seamless operation across firewalls or NAT routers.

**Network Isolation:**

* Popsink exposes only a single IP address for VPN connections.
* All inbound traffic to Popsink is blocked by default.
* No direct communication with Popsink’s internal infrastructure components is permitted.

---

## 2. VPC Peering (Google Cloud Platform)

**VPC Peering** provides private, low-latency communication between Popsink and a customer’s Virtual Private Cloud (VPC) in **Google Cloud Platform (GCP)** — without traversing the public internet or requiring public IP addresses.

**Key Characteristics:**

* **Private Connectivity:** Traffic between VPCs remains within Google’s private backbone, ensuring privacy and low latency.
* **Controlled Routing:** Routes must be explicitly defined and accepted by both sides. No automatic propagation occurs without explicit authorization.
* **Logical Isolation:** Even though the VPCs are peered, they remain logically isolated. GCP firewall rules can be used to control and filter inter-VPC traffic.
* **Fine-Grained Access Control:**

  * **IAM Rules:** Restrict access to resources based on user, project, or service identity.
  * **Firewall Rules:** Enable filtering by IP range, tag, service account, or protocol.
* **Non-Transitive Peering:** VPC peering connections are not transitive. (For example, if VPC A ↔ VPC B and VPC B ↔ VPC C, VPC A ↔ VPC C is *not* automatically established.) This limits the potential attack surface.
* **No Intra-Region Egress Charges:** Traffic within the same region is not billed, supporting high-performance and cost-efficient designs.
