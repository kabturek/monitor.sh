# Quick reference

- **Where to file issues with docker image**:
  [monitor.sh docker image github](https://github.com/kabturek/monitor.sh/issues)

-	**Monitor source**:  
  [andrewjfreyer/monitor Github](https://github.com/andrewjfreyer/monitor)

-	**Monitor forum thread**:  
  [Home Assistant forum thread](https://community.home-assistant.io/t/monitor-reliable-multi-user-distributed-bt-occupancy-presence-detection/68505)

# What is Monitor.sh?

Bluetooth-based passive presence detection of beacons, cell phones, and any other bluetooth device. The system is useful for mqtt-based home automation.

# How to use this image


## Configuration

When running the image, the default configuration is stored in /config. To use custom configuration, mount a **local** configuration directory to `/config`

## First run

```console
$ docker run -it --rm --net=host --cap-add=NET_ADMIN -v /local/config/:/config monitor.sh
```

Use an empty local directory as a config dir - on first run the script will
create empty configuration file that you have to edit:

    known_beacon_addresses  
    known_static_addresses   
    mqtt_preferences

## Running the image

--net=host is needed so the script will have access to hci0
--cap-add=NET_ADMIN is needed so that the script can cycle the hci0 bluetooth interface

```console
$ docker run -it -d --net=host --cap-add=NET_ADMIN -v /local/config/:/config monitor.sh
```

## Running with different options

You can add different script options (refer to the script readme file)

```console
$ docker run -it -d --net=host --cap-add=NET_ADMIN -v /local/config/:/config monitor.sh bash monitor.sh -b -g
```

## Displaying help / Running one-off commands

```console
$ docker run -it --rm --net=host --cap-add=NET_ADMIN -v /local/config/:/config monitor.sh bash monitor.sh -h
```

## docker-compose

Here is a sample docker-compose file. You can drop the command if you don't need
a custom command.

```
version: '3'
services:
  monitor.sh:
    image: kabturek/monitor.sh
    container_name: monitor.sh
    restart: always
    volumes: 
      - /srv/monitor:/config
    network_mode: host
    cap_add:
      - NET_ADMIN
    command: bash monitor.sh -e -x -g -D /config
```

Running:

```console
$ docker-compose up -d monitor.sh
```
