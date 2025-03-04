# orangepi5-security

### Instruction 

You need to place the image of "Orange Pi 5"(debian) in the folder: 

``` sh 
├── README.md
├── orangepi.img
├── src
│   ├── check_serial.service
│   ├── check_serial.sh
│   └── take_serial.service
└── update_img.sh
```
> !!! the name should be only orangepi.img !!!

After that start the script 

``` bash 
./update_img.sh
```

As a result, you will see an image with the name "orangepi_ready_made.img"