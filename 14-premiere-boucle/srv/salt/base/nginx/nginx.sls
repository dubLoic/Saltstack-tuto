
installation de nginx:
  pkg.installed:
    - pkgs:
      - nginx

start nginx:
  service.running:
    - name: nginx
