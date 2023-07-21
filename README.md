# viv-docker
build system for local copy of  Viv application

## how to build the docker container locally
`docker build -t vivdocker .`

Please NOTE:  the above build command must be performed outside of the NIH firewall. The build attempts to pull content from the internet during the compilation, which is blocked by the NIH firewall.  


## how to run the container 
Once the container build process completes (which may take a few minutes), then the following command can be used to run the container on your local system:

`docker run --rm -it -p 3000:3000 vivdocker`

This will run the container and open AVIVATOR on the local port 3000.  Then open this link with your browser:

`http://localhost:3000`

AVIVATOR should load a sample image.  You may load local files of the type OME.TIFF by clicking the button entitled "CHOOSE A FILE" and choosing them from the browser.  **This is the fastest way to load local OME-TIFF files.** 

## how to convert images 

 The free NGFF-Converter is available at (https://www.glencoesoftware.com/products/ngff-converter/) and is handy to convert files into ome-tiff and zarr format. The conversion process will take a long time for large files.  Using this application is easier than running the bioformats converter by hand. 

## advanced: reading of ZARR (OME-NGFF) format files

This docker container also contains a built-in web server to serve ZARR files from the local disk to AVIVATOR by typing the url in the top box (overwriting the sample image URL).  For this method to work, several steps are required:

1. The web browser must have CORS (cross origin resource sharing) enabled.  There are plugins available for all major browsers to allow this.  Install a CORS plugin in the web browser and enable it. 

2. Make sure the ZARR file is in the correct format for reading.  The Glencoe NGFF converter makes Zarr files that need to be manually rearranged before they are readable:  (1)Copy all files from the OME subdirectory up one level in the hierarchy (into the roof folder of the image), (2) make a new directory in the root called `data.zarr` and move the 0, 1, etc. directories into `data.zarr`.  

3. Be sure you have explosed port 8000 when running the docker container.  This is the port used by the server.  In order to do this, run the container with the following command:

`docker run --rm -it -v host-computer-image-dirctory:/data -p 3000:3000 -p 8000:8000 vivdocker`

The `-v` command maps a folder on the host computer (containing images to view) to the /data directory for the built-in web server.  the `-p` command maps ports on the container into the network address space of the host computer. 

4. Then put the URL `http://localhost:8000/<imagename>/` into your browser. For example, to view the 20XLung.zarr file, enter `http://localhost:8000/20XLung.zarr/` 

