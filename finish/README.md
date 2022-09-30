## InstantOn

1. Build the application.
   ```
   mvn install
   ```

1. Build the base container image.
   ```
   sudo ./build-og.sh
   ```

1. Build the InstantOn container image. Review the script, especially the checkpoint environment variable and the privileged option.
   ```
   sudo ./build-instanton.sh
   ```

1. Start a container using the base image.
   ```
   sudo ./run-og.sh
   ```

1. Start a container using the InstantOn image. Review the script, especially the additional capabilities. After the application starts, compare the start up time with the base image.
   ```
   sudo ./run-instanton.sh
   ```
