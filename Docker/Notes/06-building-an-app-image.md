## Build an app image


#### Now that you have a base image, you can extend that image to build additional images.

#### Start a new container using the newly created node-base image:
```
docker run --name=app-container -ti ubuntu
```
#### Inside of this container, run the following command to create a Node program:
```
echo 'console.log("Hello from an app")' > app.js
```
#### Inside the container, run the following command to install Node.js:
```
apt update && apt install -y nodejs
```
#### To run this Node program, you can use the following command and see the message printed on the screen:
```
node app.js
```
#### In another terminal, run the following command to save this container’s changes as a new image:
```
docker container commit -c "CMD node app.js" -m "Add app" app-container sample-app
```

#### You can also tag image with your image with repo name as well

```
docker containe commit -c "node js app image build" -m "Add app" app-container anantgsaraf/nodejs-app
```

```
docker push anantgsaraf/nodejs-app
```

#### Now above image can be used by anyone for testing

#### This command not only creates a new image named sample-app, but also adds additional configuration to the image to set the default command when starting a container. In this case, you are setting it to automatically run node app.js.

#### In a terminal outside of the container, run the following command to view the updated layers:
```
docker image history sample-app
```
#### You’ll then see output that looks like the following. Note the top layer comment has “Add app” and the next layer has “Add node”:

```
IMAGE          CREATED              CREATED BY                                      SIZE      COMMENT
```

##### This command not only creates a new image named sample-app, but also adds additional configuration to the image to set the default command when starting a container. In this case, you are setting it to automatically run node app.js.

#### In a terminal outside of the container, run the following command to view the updated layers:
```
docker image history sample-app
```
#### You’ll then see output that looks like the following. Note the top layer comment has “Add app” and the next layer has “Add node”:

```
IMAGE          CREATED              CREATED BY                                      SIZE      COMMENT
c1502e2ec875   About a minute ago   /bin/bash                                       33B       Add app
5310da79c50a   4 minutes ago        /bin/bash                                       126MB     Add node
2b7cc08dcdbb   5 weeks ago          /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
<missing>      5 weeks ago          /bin/sh -c #(nop) ADD file:07cdbabf782942af0…   69.2MB
<missing>      5 weeks ago          /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B
<missing>      5 weeks ago          /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B
<missing>      5 weeks ago          /bin/sh -c #(nop)  ARG LAUNCHPAD_BUILD_ARCH     0B
<missing>      5 weeks ago          /bin/sh -c #(nop)  ARG RELEASE                  0B
```

#### Finally, start a new container using the brand new image. Since you specified the default command, you can use the following command:
```
docker run sample-app
```
#### You should see your greeting appear in the terminal, coming from your Node program.

#### Now that you’re done with your containers, you can remove them using the following command:
```
docker rm -f app-container
```