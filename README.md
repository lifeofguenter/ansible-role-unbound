# Ansible Role for unbound

[![CircleCI](https://circleci.com/gh/lifeofguenter/ansible-role-unbound/tree/main.svg?style=svg)](https://circleci.com/gh/lifeofguenter/ansible-role-unbound/tree/main)

This ansible role will install unbound.

## Requirements

_None_

## Role Variables

```yaml
unbound_interfacess:
  - 127.0.0.1

unbound_listen_port: 53

unbound_memory: 384

unbound_num_threads: "{{ ansible_processor_vcpus }}"

unbound_access_control:
  - 127.0.0.0/8 allow
  - 10.0.0.0/8 allow
  - 172.16.0.0/12 allow
  - 192.168.0.0/16 allow

# Keep probing hosts marked down instead of caching them as unreachable
# for the full TTL. Enabled by default for resilience; set to 'no' to disable.
unbound_infra_keep_probing: 'yes'
```

### Disabling DNSSEC validation for specific domains

```yaml
unbound_domain_insecure:
  - example.internal
  - corp.example.com
```

### RPZ block lists

Provide a list of Response Policy Zones. Defining any zone automatically
loads the `respip` module. Each zone can be sourced from a `url` and/or a
local `zonefile`:

```yaml
unbound_rpz_zones:
  - name: urlhaus
    url: https://urlhaus.abuse.ch/downloads/rpz/
    zonefile: /var/lib/unbound/rpz-urlhaus.zone
    rpz_action_override: nxdomain
```

### Forward zones

Provide a list of forward zones. If any address contains a `#` (the
DNS-over-TLS authentication name), `forward-tls-upstream` is enabled
automatically for that zone:

```yaml
unbound_forward_zones:
  - name: "."
    addrs:
      - 1.1.1.1@853#cloudflare-dns.com
      - 1.0.0.1@853#cloudflare-dns.com
  - name: internal.example.com
    addrs:
      - 10.0.0.53
```

## Dependencies

_None_

## Example Playbook

```
- hosts: servers
  roles:
    - { role: lifeofguenter.unbound }
```

## License

MIT

## Author Information

[Gunter Grodotzki](https://lifeofguenter.de)
