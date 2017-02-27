[![Build Status](https://travis-ci.org/lifeofguenter/ansible-role-unbound.svg?branch=master)](https://travis-ci.org/lifeofguenter/ansible-role-unbound)

# Ansible Role for unbound

This ansible role will install unbound

## Requirements

_None_

## Role Variables

```
unbound_interfacess: '["127.0.0.1", "127.0.0.2"]'
```

```
unbound_memory: 384
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

Gunter Grodotzki <gunter@grodotzki.co.za>
