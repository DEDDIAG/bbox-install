# BBOX Installer
Installer script for [bbox](https://github.com/DEDDIAG/bbox), and Domestic Energy Monitoring System.

For a general overview  of the Domestic Energy Monitoring System see [deddiag.github.io](https://deddiag.github.io).

This script automate the complete installation process of bbox.
For a bbox usage help please consult the bbox [README.md](https://github.com/DEDDIAG/bbox/README.md)

## Flash Hypriot OS
Flash Hypriot OS to an SD-Card using one of the following methods.
## Simple Install using Hypriot OS flash tool
https://github.com/hypriot/flash


## Manual Install (alternative)
Download Hypriot OS and unzip
```
https://blog.hypriot.com/downloads/
```

Flash to SD-Card
**WARNING**: Change `/dev/sdb` to what ever the SD-Card is, all data on device will be lost!
```
df -h
umount /dev/sdb1
sudo dd bs=4M if=<HYPRIOT-IMAGE> of=/dev/sdb
```

## Install bbox
Boot Raspberry and find it's IP on the network.

Execute the following install from your system!
```
echo "SYSTEM_PASSWORD='<NEW_SYSTEM_PASSWORD>' HOUSE='<HOUSE>' REMOTE_HOST='<REMOTE_HOST>'" | cat - install.sh | ssh pirate@<IP> 'bash -s'
```
After a successful installation, the system will reboot automatically.

## Add Measurement devices/bindings
The bindings can either be added using the the WebUI or using the following scripts.

### Add TP-Link Bridge
```
add-tplinkbridge.sh -p <IP>
```

### Add Modbus Bridge and Phases
```
add-modbus.sh -p <IP>
```

## Citation
When using the system in academic work please cite [this paper](https://doi.org/10.1038/s41597-021-00963-2) as the reference.

```
@article{DEDDIAG_2021,
  author = {Marc Wenninger and Andreas Maier and Jochen Schmidt},
  title = {{DEDDIAG}, a domestic electricity demand dataset of individual appliances in Germany},
  year = {2021},
  month = jul,
  volume = {8},
  number = {1},
  journal = {Scientific Data},
  doi = {https://doi.org/10.1038/s41597-021-00963-2},
  url = {https://rdcu.be/coGqL},
}
```

## Acknowledgements
The monitoring system and dataset were created as part of a research project of the [Technical University of Applied Sciences Rosenheim](https://www.th-rosenheim.de/).

The project was funded by the [German Federal Ministry of Education and Research (BMBF)](https://www.bmbf.de/), grant 01LY1506,
and supported by the [Bayerische Wissenschaftsforum (BayWISS)](https://www.baywiss.de/).

![](https://www.th-rosenheim.de/typo3conf/ext/in2template/Resources/Public/Images/logo-th-rosenheim-2019.png)

## License
This software is MIT licensed, as found in the [LICENSE](./LICENSE) file.