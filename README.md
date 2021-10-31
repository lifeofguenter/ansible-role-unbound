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
