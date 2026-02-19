## Explanation

```
As you learned in What is an image?, container images are composed of layers. 
And each of these layers, once created, are immutable. 
But, what does that actually mean? And how are those layers used to create the filesystem a container can use?
```

## Image layers

```
Each layer in an image contains a set of filesystem changes - 
additions, deletions, or modifications. Let’s look at a theoretical image:

- The first layer adds basic commands and a package manager, such as apt.

- The second layer installs a Python runtime and pip for dependency management.

- The third layer copies in an application’s specific requirements.txt file.

- The fourth layer installs that application’s specific dependencies.

- The fifth layer copies in the actual source code of the application.
```

![Image-example](../images/container_image_layers.webp)

#### In a terminal, run the following command to start a new container:

```
docker run --name=base-container -ti ubuntu
```

#### Once the image has been downloaded and the container has started, you should see a new shell prompt. 
#### This is running inside your container. It will look similar to the following (the container ID will vary):

```
root@d8c5ca119fcd:/#
```

#### Inside the container, run the following command to install Node.js:

```
apt update && apt install -y nodejs
```

#### When this command runs, it downloads and installs Node inside the container. In the context of the union filesystem, these filesystem changes occur within the directory unique to this container.

#### Validate if Node is installed by running the following command:

```
node -e 'console.log("Hello world!")'
```

#### You should then see a “Hello world!” appear in the console.

#### Now that you have Node installed, you’re ready to save the changes you’ve made as a new image layer, from which you can start new containers or build new images. To do so, you will use the docker container commit command. Run the following command in a new terminal:

```
docker container commit -m "Add node" base-container node-base
```

#### View the layers of your image using the docker image history command:

```
docker image history node-base
```

#### You will see output similar to the following:

```
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
d5c1fca2cdc4   10 seconds ago   /bin/bash                                       126MB     Add node
2b7cc08dcdbb   5 weeks ago      /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
<missing>      5 weeks ago      /bin/sh -c #(nop) ADD file:07cdbabf782942af0…   69.2MB
<missing>      5 weeks ago      /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B
<missing>      5 weeks ago      /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B
<missing>      5 weeks ago      /bin/sh -c #(nop)  ARG LAUNCHPAD_BUILD_ARCH     0B
<missing>      5 weeks ago      /bin/sh -c #(nop)  ARG RELEASE                  0B
```

#### Note the “Add node” comment on the top line. This layer contains the Node.js install you just made.

#### To prove your image has Node installed, you can start a new container using this new image:

```
docker run node-base node -e "console.log('Hello again')"
```

#### With that, you should get a “Hello again” output in the terminal, showing Node was installed and working.

#### Now that you’re done creating your base image, you can remove that container:

```
docker rm -f base-container
```

