# Update SDK

Any time you change the content of CDE or SDK images you should build and publish them.
Here's the procedure to follow:

## Update

1. Update `Dockerfile.*` with your changes.
2. Bump the tag (version) of corresponding image in `*.yml` files.

   **Example**: If you want to update the `builder` image which has version 1 (the image is
   `builder:1`), after changing the `sdk/Dockerfile.builder`, you should also change
   `sdk/sdk.yml` and increment tag the of the image to `builder:2`.

3. Bump the tag of all dependent subsequent images in corresponding `Dockerfile.*` and `*.yml`
   files.

   **Example**: If you've updated `builder` image to version 2, you must also update the
   dependent `developer` image from version 1 to version 2.

## Build

It is recommended to build SDK images inside of CDE container.

```shell
[username@CDE-hostname CDE]$ cmt run
[CDE#username_1 CDE]$ sudo docker-compose -f sdk/sdk.yml build
```

## Publish

To push SDK image to **Artifactory** you should be logged in and have write permissions.
Login and push the images.

```shell
[CDE#username_1 CDE]$ sudo docker login your-artifactory.net
Username: username
Password:
...
Login Succeeded
[CDE#username_1 CDE]$ sudo docker-compose -f sdk/sdk.yml push
```

## Advertise

Compose all changes and explanations into "Release Notes" email and notify CDE users about the
change, so they can plan their workspace upgrade.
