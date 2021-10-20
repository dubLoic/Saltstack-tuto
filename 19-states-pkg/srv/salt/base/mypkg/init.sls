
Add docker repository:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/{{ grains['os'] | lower }} {{ grains['oscodename'] }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 0EBFCD88
    - keyserver: https://download.docker.com/linux/{{ grains['os'] | lower }}/gpg
    - refresh_db: true

Install docker packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - cache_valid_time: 3600
    - refresh: True

Add vagrant user docker group:
  group.present:
    - name: docker
    - addusers:
      - vagrant

