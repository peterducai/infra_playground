# Docker registry under podman

> podman run -d -p 5000:5000 --name registry registry:2

> podman image tag fedora localhost:5000/myfirstimage

> podman push localhost:5000/myfirstimage

> podman pull localhost:5000/myfirstimage

Now stop your registry and remove all data

> podman container stop registry && podman container rm -v registry