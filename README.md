# ubuntu-boost-dockerfile
Creating a Docker image of Ubuntu with build library boost

## Build
To build the image, you should either modify config_file or run `./build.sh` with arguments like

```bash
./build.sh olned 20.04 1.74.0
```

./build.sh changes config_file after every run.


## Push
To push an image to Docker Hub, you should just run `./push.sh`, it will use last arguments from config_file

```bash
./push.sh
```

You can also change the config file or specify parameters when running `./push.sh`.
`./push.sh` does not change config_file.