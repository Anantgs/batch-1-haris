### Explanation

![container image layer](../images/container-image-layers.png)


```
Seeing a container is an isolated process, where does it get its files and configuration? 
How do you share those environments?

That's where container images come in. A container image is a standardized package that includes 
all of the files, binaries, libraries, and configurations to run a container.

For a PostgreSQL image, that image will package the database binaries, config files, and other dependencies. 
For a Python web app, it'll include the Python runtime, your app code, and all of its dependencies.

There are two important principles of images:

Images are immutable. Once an image is created, it can't be modified. 
You can only make a new image or add changes on top of it.

Container images are composed of layers. Each layer represents a set of file system changes that add, 
remove, or modify files.

These two principles let you to extend or add to existing images. For example, 
if you are building a Python app, you can start from the Python image and add additional 
layers to install your app's dependencies and add your code. This lets you focus on your app, 
rather than Python itself.
```

### Where to find images

```
Docker Hub is the default registry for Docker images. 
It's a public registry that's available to everyone. 
You can also run your own private registry.  

```

### command

```
docker search docker/welcome-to-docker
```

### How to pull the image   

```
docker pull docker/welcome-to-docker
```

### List your downloaded images using the docker image ls command:

```
docker image ls
```

### *** The image size represented here reflects the uncompressed size of the image, not the download size of the layers. ***